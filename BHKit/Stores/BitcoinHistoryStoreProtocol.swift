//
//  BitcoinHistoryStoreProtocol.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public protocol BitcoinHistoryStoreProtocol {
  func getCurrentPrice(currencyCode: CurrencyCode?, completion: @escaping (Result<PriceDetail, Error>) -> Void)
  func getHistorical(start: Date?, end: Date?, currencyCode: CurrencyCode?, completion: @escaping (Result<HistoricalList, Error>) -> Void)
}
