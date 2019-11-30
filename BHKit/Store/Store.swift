//
//  Store.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public class Store: StoreProtocol {
  private let bitcoinHistoryClient = BitcoinHistoryClient()
  
  private lazy var formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    
    return formatter
  }()
  
  // MARK: Object lifecycle
  
  public init() { }
  
  // MARK: Business logic
  
  public func getCurrentPrice(currencyCode: CurrencyCode?, completion: @escaping (Result<PriceDetail, Error>) -> Void) {
    bitcoinHistoryClient.getCurrentPrice(currencyCode: currencyCode) { (result) in
      switch result {
      case .success(let response):
        do {
          let priceDetail = try self.currentPriceResponseToPriceDetail(priceResponse: response)
          completion(.success(priceDetail))
        } catch let error {
          completion(.failure(error))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func getHistorical(start: Date?, end: Date?, currencyCode: CurrencyCode?, completion: @escaping (Result<HistoricalList, Error>) -> Void) {
    let selectedCurrencyCode = currencyCode ?? deviceLocaleCurrencyCode()
    
    bitcoinHistoryClient.getHistorical(start: start, end: end, currencyCode: selectedCurrencyCode) { (result) in
      switch result {
      case .success(let response):
        do {
          let historicalList = try self.historicalResponseToHistoricalList(historicalResponse: response, currencyCode: selectedCurrencyCode)
          completion(.success(historicalList))
        } catch let error {
          completion(.failure(error))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  public func getHistoricDetail(date: Date, completion: @escaping (Result<PriceDetail, Error>) -> Void) {
    let historicDetailsDispatchGroup = DispatchGroup()
    var currencyDetails: [CurrencyDetail] = []
    var getHistoricDetailError: Error?

    CurrencyCode.all.forEach { (currencyCode) in
      historicDetailsDispatchGroup.enter()
      bitcoinHistoryClient.getHistorical(start: date, end: date, currencyCode: currencyCode) { (result) in
        historicDetailsDispatchGroup.leave()
        
        switch result {
        case .success(let response):
          if let currencyDetail = self.historicalResponseToCurrencyDetail(historicalResponse: response, currencyCode: currencyCode, date: date) {
            currencyDetails.append(currencyDetail)
          } else {
            getHistoricDetailError = StoreError.unexpectedResponse
          }
        case .failure(let error):
          getHistoricDetailError = error
        }
      }
    }
    
    historicDetailsDispatchGroup.notify(queue: DispatchQueue.main) {
      if let error = getHistoricDetailError {
        completion(.failure(error))
      } else {
        let priceDetail = PriceDetail(
          disclaimer: "",
          date: date,
          currentCurrencyCode: self.deviceLocaleCurrencyCode(),
          currencyDetails: currencyDetails
        )
        completion(.success(priceDetail))
      }
    }
  }
  
  // MARK: Helpers
  
  private func convertToFormattedCurrency(_ rate: Float, code: String? = nil) -> String {
    let currencyCode = code ?? deviceLocaleCurrencyCode().rawValue
    formatter.currencyCode = currencyCode
    
    let rateDecimal = NSDecimalNumber(value: rate)
    guard let formattedValue = formatter.string(from: rateDecimal) else {
      assertionFailure("Should always be capable to format a rate")
      return "\(rate)"
    }
    
    return formattedValue
  }
  
  private func deviceLocaleCurrencyCode() -> CurrencyCode {
    if let code = Locale.current.currencyCode, let currencyCode = CurrencyCode(rawValue: code) {
      return currencyCode
    }
    
    return .usd
  }
  
  private func currentPriceResponseToPriceDetail(priceResponse: CurrentPriceResponse) throws -> PriceDetail {
    guard let date = Date.from(date: priceResponse.time.updated, format: .long) else {
      throw StoreError.unexpectedResponse
    }
    
    let currencyDetails: [CurrencyDetail] = priceResponse.bpi.compactMap {
      detailCurrentPriceResponseToCurrencyDetail(detailCurrentPriceResponse: $0.value)
    }
    
    return PriceDetail(
      disclaimer: priceResponse.disclaimer,
      date: date,
      currentCurrencyCode: deviceLocaleCurrencyCode(),
      currencyDetails: currencyDetails
    )
  }
  
  private func historicalResponseToHistoricalList(historicalResponse: HistoricalResponse, currencyCode: CurrencyCode) throws -> HistoricalList {
    let historicRates = try historicalResponse.bpi.map { (dictionaryEntry) -> HistoricRate in
      let (dateString, bitcoinRate) = dictionaryEntry
      
      guard let date = Date.from(date: dateString, format: .short) else {
        throw StoreError.unexpectedResponse
      }
      
      return HistoricRate(date: date, rate: bitcoinRate, rateLocaleFormatted: convertToFormattedCurrency(bitcoinRate))
    }
    
    return HistoricalList(
      disclaimer: historicalResponse.disclaimer,
      updatedDate: historicalResponse.time.updated,
      currencyCode: currencyCode.rawValue,
      historicRates: historicRates.sorted { $0.date > $1.date }
    )
  }
  
  private func historicalResponseToCurrencyDetail(historicalResponse: HistoricalResponse, currencyCode: CurrencyCode, date: Date) -> CurrencyDetail? {
    assert(historicalResponse.bpi.count == 1, "If converting a historical response to detail, it must have only one key-value")
    
    guard let rate = historicalResponse.bpi[date.toFormattedString()] else {
      return nil
    }
    
    return CurrencyDetail(
      code: currencyCode.rawValue,
      rate: rate,
      rateLocaleFormatted: convertToFormattedCurrency(rate, code: currencyCode.rawValue)
    )
  }
  
  private func detailCurrentPriceResponseToCurrencyDetail(detailCurrentPriceResponse: DetailCurrentPriceResponse) -> CurrencyDetail {
    return CurrencyDetail(
      code: detailCurrentPriceResponse.code,
      rate: detailCurrentPriceResponse.rateFloat,
      rateLocaleFormatted: convertToFormattedCurrency(detailCurrentPriceResponse.rateFloat, code: detailCurrentPriceResponse.code)
    )
  }
}
