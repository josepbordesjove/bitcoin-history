//
//  HistoricalList.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public struct HistoricalList {
  public let disclaimer: String
  public let updatedDate: String
  public let currencyCode: String
  public let historicRates: [HistoricRate]
}
