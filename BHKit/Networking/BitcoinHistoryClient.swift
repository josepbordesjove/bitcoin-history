//
//  BitcoinHistoryClient.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

class BitcoinHistoryClient: APIClient {
  var logLevel: APIClientLogLevel

  init() {
    #if DEBUG
    self.logLevel = .debug
    #else
    self.logLevel = .none
    #endif
  }
  
  // MARK: Public endpoints
  
  func getCurrentPrice(currencyCode: CurrencyCode?, completion: @escaping (Result<CurrentPriceResponse, Error>) -> Void) {
    let endpoint: CoinDeskEndpoint = .currentPrice(currencyCode: currencyCode)
    self.load(endpoint: endpoint, responseType: CurrentPriceResponse.self, completion: completion)
  }
  
  func getHistorical(start: Date?, end: Date?, currencyCode: CurrencyCode, completion: @escaping (Result<HistoricalResponse, Error>) -> Void) {
    let endpoint: CoinDeskEndpoint = .historical(start: start, end: end, currencyCode: currencyCode)
    self.load(endpoint: endpoint, responseType: HistoricalResponse.self, completion: completion)
  }
  
  // MARK: Helpers
  
  internal func urlRequest(from endpoint: Endpoint) -> URLRequest? {
    var urlComponents = URLComponents()
    urlComponents.scheme = endpoint.scheme
    urlComponents.host = endpoint.host
    
    if endpoint is CoinDeskEndpoint {
      urlComponents.path = "/" + endpoint.version + "/" + endpoint.basePath + "/" + endpoint.path
    }
    
    if case .get(let parameters) = endpoint.method {
      if let parameters = parameters {
        urlComponents.queryItems = parameters.compactMap { return URLQueryItem(name: $0.key, value: "\($0.value)") }
      }
    }

    guard let url = urlComponents.url else { return nil }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = endpoint.method.value
    
    let headers = ["Content-Type": "application/json"]
    headers.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
    
    switch endpoint.method {
    case .get:
      break
    case .post(let body):
      if let body = body, let bodyData = try? JSONSerialization.data(withJSONObject: body, options: []) {
          urlRequest.httpBody = bodyData
      }
    }

    return urlRequest
  }
}
