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
  case unexpectedResponse
}

extension StoreError {
    public var errorDescription: String? {
        return localizedDescription
    }

    var description: String? {
        switch self {
        case .networkError:
          return NSLocalizedString("There has been an unexpected error trying to fetch the data, try it again", comment: "")
        case .unexpectedResponse:
          return NSLocalizedString("The response from the server was unexpected, please, try it again", comment: "")
        }
    }
}
