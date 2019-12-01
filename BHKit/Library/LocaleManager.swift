//
//  LocaleManager.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 01/12/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

class LocaleManager {
  private lazy var formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    
    return formatter
  }()
  
  func convertToFormattedCurrency(_ rate: Float, currency: Currency? = nil) -> String {
    let toFormatCurrency = currency ?? deviceLocaleCurrency()
    formatter.currencyCode = toFormatCurrency.rawValue
    
    let rateDecimal = NSDecimalNumber(value: rate)
    guard let formattedValue = formatter.string(from: rateDecimal) else {
      assertionFailure("Should always be capable to format a rate")
      return "\(rate)"
    }
    
    return formattedValue
  }
  
  func deviceLocaleCurrency() -> Currency {
    if let code = Locale.current.currencyCode, let currencyCode = Currency(rawValue: code) {
      return currencyCode
    }
    
    return .usd
  }
}
