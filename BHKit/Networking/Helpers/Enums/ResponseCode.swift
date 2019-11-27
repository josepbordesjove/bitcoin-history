//
//  ResponseCode.swift
//  iqb-network-package
//
//  Created by Josep Bordes Jové on 22/11/2019.
//

import Foundation

enum ResponseCode: Int {
    case informational = 1
    case successful = 2
    case redirection = 3
    case clientError = 4
    case serverError = 5

    var summary: String {
        switch self {
        case .informational, .redirection:
            return "UNEXPECTED"
        case  .clientError, .serverError:
            return "FAILED"
        case .successful:
            return "SUCCESS"
        }
    }

    var emoji: String {
        switch self {
        case .informational:
            return "🥺"
        case .successful:
            return "🤩"
        case .redirection:
            return "🤯"
        case .clientError:
            return "🤬"
        case .serverError:
            return "🥵"
        }
    }

    var description: String {
        switch self {
        case .informational:
            return "The request was received, continuing process"
        case .successful:
            return "The request was successfully received, understood, and accepted"
        case .redirection:
            return "Further action needs to be taken in order to complete the request"
        case .clientError:
            return "The request contains bad syntax or cannot be fulfilled"
        case .serverError:
            return "The server failed to fulfill an apparently valid request"
        }
    }
}
