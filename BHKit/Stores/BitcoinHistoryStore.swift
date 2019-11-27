//
//  BitcoinHistoryStore.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public class BitcoinHistoryStore: BitcoinHistoryStoreProtocol {
  
  private let bitcoinHistoryClient = BitcoinHistoryClient()
  
  // MARK: Object lifecycle
  
  public init() { }
  
  // MARK: Business logic
  
  public func getCurrentPrice(currencyCode: CurrencyCode?, completion: @escaping (Result<PriceDetail, Error>) -> Void) {
    bitcoinHistoryClient.getCurrentPrice(currencyCode: currencyCode) { (result) in
      switch result {
      case .success(let response):
        let priceDetail = PriceDetail(
          disclaimer: response.disclaimer,
          date: response.time.updated,
          currencyDetails: []
        )
        
        completion(.success(priceDetail))
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
        let historicalList = HistoricalList(
          disclaimer: response.disclaimer,
          updatedDate: response.time.updated,
          currencyCode: selectedCurrencyCode.rawValue,
          historicRates: response.bpi.compactMap { HistoricRate(date: $0.key, rate: $0.value) }
        )
        
        completion(.success(historicalList))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  // MARK: Helpers
  
  func deviceLocaleCurrencyCode() -> CurrencyCode {
    // TODO: Retrieve the real code from the device
    return .eur
  }
}
