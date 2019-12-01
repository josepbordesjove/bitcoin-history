//
//  APIClient.swift
//  iqb-network-package
//
//  Created by Josep Bordes Jové on 22/11/2019.
//

import Foundation

public protocol APIClient: APIClientType {
  var logLevel: APIClientLogLevel { get }
  func urlRequest(from endpoint: Endpoint) -> URLRequest?
  func loadDataTask(endpoint: Endpoint, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}
