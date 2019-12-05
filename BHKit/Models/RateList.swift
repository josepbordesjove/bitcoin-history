//
//  RateList.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public struct RateList {
  public let disclaimer: String
  public let updatedDate: Date
  public let currentCurrency: Currency
  public let list: [Rate]
  
  public init(disclaimer: String, updatedDate: Date, currentCurrency: Currency, list: [Rate]) {
    self.disclaimer = disclaimer
    self.updatedDate = updatedDate
    self.currentCurrency = currentCurrency
    self.list = list
  }
  
  public init?(response: CurrentPriceResponse, currentCurrency: Currency) {
    guard let updatedDate = Date.from(date: response.time.updated, format: .long) else {
      return nil
    }
    
    self.disclaimer = response.disclaimer
    self.updatedDate = updatedDate
    self.currentCurrency = currentCurrency
    self.list = response.bpi.compactMap({ dictionaryEntry -> Rate? in
      let (_, currentPriceResponse) = dictionaryEntry
      return Rate(response: currentPriceResponse, date: updatedDate)
    })
  }
  
  public init?(response: HistoricalResponse, currentCurrency: Currency) {
    guard let updatedDate = Date.from(date: response.time.updated, format: .long) else {
      return nil
    }
    
    self.disclaimer = response.disclaimer
    self.updatedDate = updatedDate
    self.currentCurrency = currentCurrency
    self.list = response.bpi.compactMap { Rate(date: $0.key, rate: $0.value, currency: currentCurrency) }.sorted { $0.date > $1.date }
  }
  
  var updatedDateString: String {
    return updatedDate.toFormattedString(format: .long)
  }
}

// MARK: Fake models

public extension RateList {
  static let fake = RateList(
    disclaimer: "Some disclaimer text",
    updatedDate: Date(),
    currentCurrency: .gbp,
    list: [Rate.fake3, Rate.fake5, Rate.fake2, Rate.fake1, Rate.fake0, Rate.fake9]
  )
  
  static let fake1 = RateList(
    disclaimer: "Some disclaimer text 1",
    updatedDate: Date(),
    currentCurrency: .gbp,
    list: [Rate.fake3, Rate.fake5, Rate.fake2, Rate.fake1, Rate.fake0, Rate.fake9]
  )
}
