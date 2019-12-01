//
//  MemStore.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public class MemStore: StoreProtocol {
  // MARK: Object lifecycle
  
  public init() { }
  
  // MARK: Business logic

  public func getCurrentPrice(currency: Currency?, completion: @escaping (Result<RateList, Error>) -> Void) {
    completion(.success(RateList.fake))
  }
  
  public func getHistorical(start: Date?, end: Date?, currency: Currency?, completion: @escaping (Result<RateList, Error>) -> Void) {
    completion(.success(RateList.fake))
  }
  
  public func getHistoricDetail(rate: Rate?, completion: @escaping (Result<RateList, Error>) -> Void) {
    if rate == nil {
      completion(.failure(StoreError.unexpectedResponseHistoricDetail))
    } else {
      completion(.success(RateList.fake))
    }
  }
  
  public func startListeningForTodayUpdates(timeIntervalToRefresh: Double, completion: @escaping (Result<RateList, Error>) -> Void) {
    completion(.success(RateList.fake))
  }
  
  public func stopListeningForTodayUpdates() {
  }
}
