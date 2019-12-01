//
//  StoreProtocol.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public protocol StoreProtocol {
  func getCurrentPrice(currency: Currency?, completion: @escaping (Result<RateList, Error>) -> Void)
  func getHistorical(start: Date?, end: Date?, currency: Currency?, completion: @escaping (Result<RateList, Error>) -> Void)
  func getHistoricDetail(rate: Rate?, completion: @escaping (Result<RateList, Error>) -> Void)
  func startListeningForTodayUpdates(timeIntervalToRefresh: Double, completion: @escaping (Result<RateList, Error>) -> Void)
  func stopListeningForTodayUpdates()
}
