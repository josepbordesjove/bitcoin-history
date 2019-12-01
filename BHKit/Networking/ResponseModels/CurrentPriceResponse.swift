//
//  CurrentPriceResponse.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public struct CurrentPriceResponse: Codable {
  public let disclaimer: String
  public let bpi: [String: DetailCurrentPriceResponse]
  public let time: TimeCurrentPriceResponse
}

public extension CurrentPriceResponse {
  static let fake = CurrentPriceResponse(
    disclaimer: "Some fake disclaimer",
    bpi: ["USD": DetailCurrentPriceResponse.fake, "EUR": DetailCurrentPriceResponse.fake1],
    time: TimeCurrentPriceResponse.fake
  )
}

public struct DetailCurrentPriceResponse: Codable {
  public let code: String
  public let symbol: String
  public let rate: String
  public let description: String
  public let rateFloat: Float
  
  enum CodingKeys: String, CodingKey {
      case code = "code"
      case symbol = "symbol"
      case rate = "rate"
      case description = "description"
      case rateFloat = "rate_float"
  }
}

public extension DetailCurrentPriceResponse {
  static let fake = DetailCurrentPriceResponse(
    code: "USD",
    symbol: "&#36;",
    rate: "7,620.4467",
    description: "United States Dollar",
    rateFloat: 7620.4467
  )
  
  static let fake1 = DetailCurrentPriceResponse(
    code: "EUR",
    symbol: "&euro;",
    rate: "6,916.2641",
    description: "Euro",
    rateFloat: 6916.2641
  )
}

public struct TimeCurrentPriceResponse: Codable {
  public let updated: String
  public let updatedISO: String
}

public extension TimeCurrentPriceResponse {
  static let fake = TimeCurrentPriceResponse(
    updated: "Nov 30, 2019 14:10:00 UTC",
    updatedISO: "2019-11-30T14:10:00+00:00"
  )
}
