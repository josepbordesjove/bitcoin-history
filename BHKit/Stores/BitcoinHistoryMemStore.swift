//
//  BitcoinHistoryMemStore.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public class BitcoinHistoryMemStore: BitcoinHistoryStoreProtocol {
  // MARK: Object lifecycle
  
  public init() { }
  
  // MARK: Business logic

  public func getCurrentPrice(currencyCode: CurrencyCode?, completion: @escaping (Result<PriceDetail, Error>) -> Void) {
    // Handle mem completion
  }
  
  public func getHistorical(start: Date?, end: Date?, currencyCode: CurrencyCode?, completion: @escaping (Result<HistoricalList, Error>) -> Void) {
    // Handle mem completion
  }
}
