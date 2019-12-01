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
  
  public func getCurrentPrice(currency: Currency? = nil, completion: @escaping (Result<RateList, Error>) -> Void) {
    store.getCurrentPrice(currency: currency, completion: completion)
  }
  
  public func getHistorical(start: Date?, end: Date?, currency: Currency? = nil, completion: @escaping (Result<RateList, Error>) -> Void) {
    store.getHistorical(start: start, end: end, currency: currency, completion: completion)
  }
  
  public func getHistoricDetail(rate: Rate?, completion: @escaping (Result<RateList, Error>) -> Void) {
    store.getHistoricDetail(rate: rate, completion: completion)
  }
  
  public func startListeningForTodayUpdates(timeIntervalToRefresh: Double, completion: @escaping (Result<RateList, Error>) -> Void) {
    store.startListeningForTodayUpdates(timeIntervalToRefresh: timeIntervalToRefresh, completion: completion)
  }
  
  public func stopListeningForTodayUpdates() {
    store.stopListeningForTodayUpdates()
  }
}
