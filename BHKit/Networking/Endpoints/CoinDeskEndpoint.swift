//
//  CoinDeskEndpoint.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

enum CoinDeskEndpoint: Endpoint {
  case currentPrice
  case historical(start: Date?, end: Date?, currencyCode: Currency)
  
  var scheme: String {
    return "https"
  }
  
  var host: String {
    return "api.coindesk.com"
  }
  
  var basePath: String {
    return "bpi"
  }
  
  var version: String {
    return "v1"
  }
  
  var path: String {
    switch self {
    case .currentPrice:
      return "currentprice.json"
    case .historical:
      return "historical/close.json"
    }
  }
  
  var method: HttpMethod<Body, Parameters> {
    switch self {
    case .currentPrice:
      return .get(nil)
    case .historical(let start, let end, let currency):
      if let startDate = start, let endDate = end {
        return .get([
          "start": startDate.toFormattedString(),
          "end": endDate.toFormattedString(),
          "currency": currency.rawValue
        ])
      } else {
        return .get([
          "currency": currency.rawValue
        ])
      }
    }
  }
}
