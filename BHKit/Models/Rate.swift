//
//  Rate.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public struct Rate: Equatable, Hashable {
  public let date: Date
  public let rate: Float
  public let currency: Currency
  
  public init(date: Date, rate: Float, currency: Currency) {
    self.date = date
    self.rate = rate
    self.currency = currency
  }
  
  public init?(date: String, rate: Float, currency: Currency) {
    guard let date = Date.from(date: date, format: .short) else {
      return nil
    }
    
    self.date = date
    self.rate = rate
    self.currency = currency
  }
  
  public init?(response: DetailCurrentPriceResponse, date: Date) {
    guard let currency = Currency(rawValue: response.code) else {
      return nil
    }
    
    self.date = date
    self.rate = response.rateFloat
    self.currency = currency
  }
  
  public init?(response: HistoricalResponse, currency: Currency) {
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
  static let fake0 = Rate(date: Date(timeIntervalSince1970: 000000), rate: 1.1, currency: .gbp)
  static let fake1 = Rate(date: Date(timeIntervalSince1970: 100000), rate: 20, currency: .gbp)
  static let fake2 = Rate(date: Date(timeIntervalSince1970: 200000), rate: 40, currency: .gbp)
  static let fake3 = Rate(date: Date(timeIntervalSince1970: 300000), rate: 60, currency: .gbp)
  static let fake4 = Rate(date: Date(timeIntervalSince1970: 400000), rate: 70, currency: .gbp)
  static let fake5 = Rate(date: Date(timeIntervalSince1970: 500000), rate: 80, currency: .gbp)
  static let fake6 = Rate(date: Date(timeIntervalSince1970: 600000), rate: 90, currency: .gbp)
  static let fake7 = Rate(date: Date(timeIntervalSince1970: 700000), rate: 100, currency: .gbp)
  static let fake8 = Rate(date: Date(timeIntervalSince1970: 800000), rate: 110, currency: .gbp)
  static let fake9 = Rate(date: Date(timeIntervalSince1970: 900000), rate: 120, currency: .gbp)
}
