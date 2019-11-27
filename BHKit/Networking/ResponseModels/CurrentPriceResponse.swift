//
//  CurrentPriceResponse.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

struct CurrentPriceResponse: Codable {
  let disclaimer: String
  let bpi: BPICurrentPriceResponse
  let time: TimeCurrentPriceResponse
}

struct BPICurrentPriceResponse: Codable {
  let usd: DetailCurrentPriceResponse
  let gbp: DetailCurrentPriceResponse
  let eur: DetailCurrentPriceResponse
  
  enum CodingKeys: String, CodingKey {
    case usd = "USD"
    case gbp = "GBP"
    case eur = "EUR"
  }
}

struct DetailCurrentPriceResponse: Codable {
  let code: String
  let symbol: String
  let rate: String
  let description: String
  let rateFloat: Float
  
  enum CodingKeys: String, CodingKey {
      case code = "code"
      case symbol = "symbol"
      case rate = "rate"
      case description = "description"
      case rateFloat = "rate_float"
  }
}

struct TimeCurrentPriceResponse: Codable {
  let updated: String
  let updatedISO: String
}
