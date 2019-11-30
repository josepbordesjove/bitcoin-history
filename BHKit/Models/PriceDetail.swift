//
//  PriceDetail.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public struct PriceDetail {
  public let disclaimer: String
  public let date: Date
  public let currentCurrencyCode: CurrencyCode
  public let currencyDetails: [CurrencyDetail]
}
