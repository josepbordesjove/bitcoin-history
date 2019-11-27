//
//  CurrencyCode.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public enum CurrencyCode: String {
  case eur = "EUR"
  case gbp = "GBP"
  case usd = "USD"
  
  static let all: [CurrencyCode] = [.eur, .gbp, .usd]
}
