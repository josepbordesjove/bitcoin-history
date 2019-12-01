//
//  HistoricalResponse.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public struct HistoricalResponse: Codable {
  public let bpi: [String: Float]
  public let time: TimeHistoricalResponse
  public let disclaimer: String
}

public extension HistoricalResponse {
  static let fake = HistoricalResponse(
    bpi: ["2019-09-01": 8892.5584],
    time: TimeHistoricalResponse.fake,
    disclaimer: "Fake disclaimer"
  )
}

public struct TimeHistoricalResponse: Codable {
  public let updated: String
  public let updatedISO: String
}

public extension TimeHistoricalResponse {
  static let fake = TimeHistoricalResponse(
    updated: "Sep 2, 2019 00:03:00 UTC",
    updatedISO: "2019-09-02T00:03:00+00:00"
  )
}
