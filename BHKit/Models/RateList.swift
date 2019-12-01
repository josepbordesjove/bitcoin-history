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
  
  init(disclaimer: String, updatedDate: Date, currentCurrency: Currency, list: [Rate]) {
    self.disclaimer = disclaimer
    self.updatedDate = updatedDate
    self.currentCurrency = currentCurrency
    self.list = list
  }
  
  init?(response: CurrentPriceResponse, currentCurrency: Currency) {
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
  
  init?(response: HistoricalResponse, currentCurrency: Currency) {
    guard let updatedDate = Date.from(date: response.time.updated, format: .long) else {
      return nil
    }
    
    self.disclaimer = response.disclaimer
    self.updatedDate = updatedDate
    self.currentCurrency = currentCurrency
    self.list = response.bpi.compactMap { Rate(date: $0.key, rate: $0.value, currency: currentCurrency) }
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
    list: [Rate.fake]
  )
  
  static let fake1 = RateList(
    disclaimer: "Some disclaimer text 1",
    updatedDate: Date(),
    currentCurrency: .gbp,
    list: [Rate.fake1]
  )
}