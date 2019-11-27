//
//  HistoricalResponse.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

struct HistoricalResponse: Codable {
  let bpi: [String: Float]
  let time: TimeHistoricalResponse
  let disclaimer: String
}

struct TimeHistoricalResponse: Codable {
  let updated: String
  let updatedISO: String
}
