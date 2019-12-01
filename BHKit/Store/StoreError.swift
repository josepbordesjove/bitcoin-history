//
//  StoreError.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 29/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

enum StoreError: LocalizedError {
  case networkError
  case unexpectedResponseTodayRate
  case unexpectedResponseHistoricListRate
  case unexpectedResponseHistoricDetail
}

extension StoreError {
  public var errorDescription: String? {
    return description
  }
  
  public var localizedDescription: String? {
    return description
  }
  
  var description: String? {
    switch self {
    case .networkError:
      return NSLocalizedString("There has been an unexpected error trying to fetch the data, try it again", comment: "")
    case .unexpectedResponseTodayRate:
      return NSLocalizedString("There has been an error trying to fetch today's rate", comment: "")
    case .unexpectedResponseHistoricListRate:
      return NSLocalizedString("There has been an error trying to fetch historic list rates", comment: "")
    case .unexpectedResponseHistoricDetail:
      return NSLocalizedString("There has been an error trying to fetch the historic detail", comment: "")
    }
  }
}
