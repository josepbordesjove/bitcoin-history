//
//  Rate.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public struct Rate {
  public let date: Date
  public let rate: Float
  public let currency: Currency
  
  init(date: Date, rate: Float, currency: Currency) {
    self.date = date
    self.rate = rate
    self.currency = currency
  }
  
  init?(date: String, rate: Float, currency: Currency) {
    guard let date = Date.from(date: date, format: .short) else {
      return nil
    }
    
    self.date = date
    self.rate = rate
    self.currency = currency
  }
  
  init?(response: DetailCurrentPriceResponse, date: Date) {
    guard let currency = Currency(rawValue: response.code) else {
      return nil
    }
    
    self.date = date
    self.rate = response.rateFloat
    self.currency = currency
  }
  
  init?(response: HistoricalResponse, currency: Currency) {
    guard
      let dictionaryEntry = response.bpi.first,
      let date = Date.from(date: dictionaryEntry.key, format: .short)
    else {
      return nil
    }

    self.date = date
    self.rate = dictionaryEntry.value
    self.currency = currency
  }
  
  public var rateLocaleFormatted: String {
    let localeManager = LocaleManager()
    return localeManager.convertToFormattedCurrency(rate, currency: currency)
  }
}

// MARK: Fake models

public extension Rate {
  static let fake = Rate(date: Date(), rate: 1.1, currency: .eur)
  static let fake1 = Rate(date: Date(), rate: 20, currency: .gbp)
}
