//
//  BitcoinHistoryClient.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public class BitcoinHistoryClient: APIClient, BitcoinHistoryAPI {
  public var logLevel: APIClientLogLevel
  public var loader: LoaderProtocol
  
  // MARK: Object lifecycle

  public init(loader: LoaderProtocol) {
    self.loader = loader
    
    #if DEBUG
    self.logLevel = .minimum
    #else
    self.logLevel = .none
    #endif
  }
  
  // MARK: Public endpoints
  
  public func getCurrentPrice(completion: @escaping (Result<CurrentPriceResponse, Error>) -> Void) {
    let endpoint: CoinDeskEndpoint = .currentPrice
    self.load(endpoint: endpoint, responseType: CurrentPriceResponse.self, completion: completion)
  }
  
  public func getHistorical(start: Date?, end: Date?, currency: Currency, completion: @escaping (Result<HistoricalResponse, Error>) -> Void) {
    let endpoint: CoinDeskEndpoint = .historical(start: start, end: end, currencyCode: currency)
    self.load(endpoint: endpoint, responseType: HistoricalResponse.self, completion: completion)
  }
  
  // MARK: Helpers
  
  public func urlRequest(from endpoint: Endpoint) -> URLRequest? {
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
  
  public func loadDataTask(endpoint: Endpoint, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
    guard let urlRequest = urlRequest(from: endpoint) else {
      assert(false, "The url request from endpoint should always be unwrappable")
      completion(nil, nil, APIClientError.cannotGenerateUrlRequestProperly)
      return
    }

    loader.loadDataTask(urlRequest: urlRequest, logLevel: self.logLevel, completion: completion)
  }
}
