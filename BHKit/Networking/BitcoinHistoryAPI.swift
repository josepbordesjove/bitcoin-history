//
//  BitcoinHistoryAPI.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 01/12/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public protocol BitcoinHistoryAPI: class {
  func getCurrentPrice(completion: @escaping (Result<CurrentPriceResponse, Error>) -> Void)
  func getHistorical(start: Date?, end: Date?, currency: Currency, completion: @escaping (Result<HistoricalResponse, Error>) -> Void)
}
