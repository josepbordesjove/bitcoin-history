//
//  StoreProtocol.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public protocol StoreProtocol {
  func getCurrentPrice(currencyCode: CurrencyCode?, completion: @escaping (Result<PriceDetail, Error>) -> Void)
  func getHistorical(start: Date?, end: Date?, currencyCode: CurrencyCode?, completion: @escaping (Result<HistoricalList, Error>) -> Void)
  func getHistoricDetail(date: Date, completion: @escaping (Result<PriceDetail, Error>) -> Void)
}
