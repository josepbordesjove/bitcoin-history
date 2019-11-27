//
//  HttpMethod.swift
//  iqb-network-package
//
//  Created by Josep Bordes Jové on 22/11/2019.
//

import Foundation

typealias Parameters = [String: Any]
typealias Body = Any

enum HttpMethod<Body, Parameters> {
    case get(Parameters?)
    case post(Body?)
}

extension HttpMethod {
    var value: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
}
