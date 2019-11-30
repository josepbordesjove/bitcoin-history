//
//  Worker.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public class Worker: StoreProtocol {
  let store: StoreProtocol
  
  public init(store: StoreProtocol) {
    self.store = store
  }
  
  public func getCurrentPrice(currencyCode: CurrencyCode? = nil, completion: @escaping (Result<PriceDetail, Error>) -> Void) {
    store.getCurrentPrice(currencyCode: currencyCode, completion: completion)
  }
  
  public func getHistorical(start: Date?, end: Date?, currencyCode: CurrencyCode? = nil, completion: @escaping (Result<HistoricalList, Error>) -> Void) {
    store.getHistorical(start: start, end: end, currencyCode: currencyCode, completion: completion)
  }
  
  public func getHistoricDetail(date: Date, completion: @escaping (Result<PriceDetail, Error>) -> Void) {
    store.getHistoricDetail(date: date, completion: completion)
  }
}
