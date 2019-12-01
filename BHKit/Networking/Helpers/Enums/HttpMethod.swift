//
//  HttpMethod.swift
//  iqb-network-package
//
//  Created by Josep Bordes Jové on 22/11/2019.
//

import Foundation

public typealias Parameters = [String: Any]
public typealias Body = Any

public enum HttpMethod<Body, Parameters> {
    case get(Parameters?)
    case post(Body?)
}

public extension HttpMethod {
    var value: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
}
