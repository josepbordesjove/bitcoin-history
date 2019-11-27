//
//  APIClientError.swift
//  iqb-network-package
//
//  Created by Josep Bordes Jové on 22/11/2019.
//

import Foundation

enum APIClientError: Error {
    case cannotGenerateUrlRequestProperly
    case cannotDecodeJson
    case cannotParseResponse

    var code: Int {
        switch self {
        case .cannotGenerateUrlRequestProperly:
            return 1001
        case .cannotDecodeJson:
            return 1002
        case .cannotParseResponse:
            return 1003
        }
    }

    var description: String {
        switch self {
        case .cannotGenerateUrlRequestProperly:
            return "cannotGenerateUrlRequestProperly"
        case .cannotDecodeJson:
            return "cannotDecodeJson"
        case .cannotParseResponse:
            return "cannotParseResponse"
        }
    }
}
