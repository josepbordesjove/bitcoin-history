//
//  BitcoinHistoryWorker.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public class BitcoinHistoryWorker: BitcoinHistoryStoreProtocol {
  let store: BitcoinHistoryStoreProtocol
  
  public init(store: BitcoinHistoryStoreProtocol) {
    self.store = store
  }
  
  public func getCurrentPrice(currencyCode: CurrencyCode?, completion: @escaping (Result<PriceDetail, Error>) -> Void) {
    store.getCurrentPrice(currencyCode: currencyCode, completion: completion)
  }
  
  public func getHistorical(start: Date?, end: Date?, currencyCode: CurrencyCode? = nil, completion: @escaping (Result<HistoricalList, Error>) -> Void) {
    store.getHistorical(start: start, end: end, currencyCode: currencyCode, completion: completion)
  }
}
