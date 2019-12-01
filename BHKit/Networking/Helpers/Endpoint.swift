//
//  Endpoint.swift
//  iqb-network-package
//
//  Created by Josep Bordes Jové on 22/11/2019.
//

import Foundation

public protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var basePath: String { get }
    var version: String { get }
    var path: String { get }
    var method: HttpMethod<Body, Parameters> { get }
}
