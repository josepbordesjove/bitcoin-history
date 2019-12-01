//
//  Store.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

protocol StoreDelegate: class {
  func didUpdateTodaysRate(_ priceDetail: RateList)
}

public class Store: StoreProtocol {
  private let bitcoinHistoryClient: BitcoinHistoryAPI
  private let localeManager: LocaleManager = LocaleManager()
  private var timer: Timer?
  
  // MARK: Object lifecycle
  
  public init() {
    bitcoinHistoryClient = BitcoinHistoryClient(loader: Loader())
  }
  
  public init(client: BitcoinHistoryAPI) {
    bitcoinHistoryClient = client
  }
  
  // MARK: Business logic
  
  public func getCurrentPrice(currency: Currency?, completion: @escaping (Result<RateList, Error>) -> Void) {
    let selectedCurrency = currency ?? localeManager.deviceLocaleCurrency()

    bitcoinHistoryClient.getCurrentPrice() { (result) in
      switch result {
      case .success(let response):
        if let rateList = RateList(response: response, currentCurrency: selectedCurrency) {
          completion(.success(rateList))
        } else {
          completion(.failure(StoreError.unexpectedResponseTodayRate))
        }
      case .failure:
        completion(.failure(StoreError.unexpectedResponseTodayRate))
      }
    }
  }
  
  public func getHistorical(start: Date?, end: Date?, currency: Currency?, completion: @escaping (Result<RateList, Error>) -> Void) {
    let selectedCurrency = currency ?? localeManager.deviceLocaleCurrency()
    
    bitcoinHistoryClient.getHistorical(start: start, end: end, currency: selectedCurrency) { (result) in
      switch result {
      case .success(let response):
        if let historicRateList = RateList(response: response, currentCurrency: selectedCurrency) {
          completion(.success(historicRateList))
        } else {
          completion(.failure(StoreError.unexpectedResponseHistoricListRate))
        }
      case .failure:
        completion(.failure(StoreError.unexpectedResponseHistoricListRate))
      }
    }
  }

  public func getHistoricDetail(rate: Rate?, completion: @escaping (Result<RateList, Error>) -> Void) {
    guard let rate = rate else {
      completion(.failure(StoreError.unexpectedResponseHistoricDetail))
      return
    }
    
    let historicDetailsDispatchGroup = DispatchGroup()

    var currencyDetails: [Rate] = []
    var getHistoricDetailError: Error?
    var updatedDate: Date?
    
    Currency.all.forEach { (currency) in
      historicDetailsDispatchGroup.enter()
      
      if rate.currency == currency {
        historicDetailsDispatchGroup.leave()
        currencyDetails.append(rate)
      } else {
        bitcoinHistoryClient.getHistorical(start: rate.date, end: rate.date, currency: currency) { (result) in
          historicDetailsDispatchGroup.leave()
          
          switch result {
          case .success(let response):
            if updatedDate == nil {
              updatedDate = Date.from(date: response.time.updated, format: .long)
            }
            
            if let currencyDetail = Rate(response: response, currency: currency) {
              currencyDetails.append(currencyDetail)
            } else {
              getHistoricDetailError = StoreError.unexpectedResponseHistoricDetail
            }
          case .failure(let error):
            getHistoricDetailError = error
          }
        }
      }
    }
    
    let disclaimer = NSLocalizedString(
      "Currency detail fetched from CoinDesk. For more info visit https://www.coindesk.com",
      comment: ""
    )
    
    historicDetailsDispatchGroup.notify(queue: DispatchQueue.main) {
      if getHistoricDetailError != nil {
        completion(.failure(StoreError.unexpectedResponseHistoricDetail))
      } else if let updatedDate = updatedDate {
        let priceDetail = RateList(
          disclaimer: disclaimer,
          updatedDate: updatedDate,
          currentCurrency: self.localeManager.deviceLocaleCurrency(),
          list: currencyDetails
        )
        completion(.success(priceDetail))
      } else {
        completion(.failure(StoreError.unexpectedResponseHistoricDetail))
      }
    }
  }
  
  public func startListeningForTodayUpdates(timeIntervalToRefresh: Double, completion: @escaping (Result<RateList, Error>) -> Void) {
    let selectedCurrency = localeManager.deviceLocaleCurrency()
    let startDate = Date()

    if timer != nil {
      return
    }

    timer = Timer.scheduledTimer(withTimeInterval: timeIntervalToRefresh, repeats: true) { (_) in
      self.bitcoinHistoryClient.getCurrentPrice() { (result) in
        switch result {
        case .success(let response):
          if let rateList = RateList(response: response, currentCurrency: selectedCurrency) {
            // In order to make the loading more stabilized over time, make it at least last for 0.5 second
            let delay = -1*startDate.timeIntervalSinceNow > 0.5 ? 0 : 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
              completion(.success(rateList))
            }
          } else {
            completion(.failure(StoreError.unexpectedResponseTodayRate))
          }
        case .failure:
          completion(.failure(StoreError.unexpectedResponseTodayRate))
        }
      }
    }
  }
  
  public func stopListeningForTodayUpdates() {
    timer?.invalidate()
    timer = nil
  }
}
