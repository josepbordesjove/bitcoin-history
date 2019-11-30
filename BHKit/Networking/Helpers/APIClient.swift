//
//  APIClient.swift
//  iqb-network-package
//
//  Created by Josep Bordes Jové on 22/11/2019.
//

import Foundation

protocol APIClient: APIClientType {
  var logLevel: APIClientLogLevel { get }
  func urlRequest(from endpoint: Endpoint) -> URLRequest?
}

extension APIClient {
  internal func loadDataTask(endpoint: Endpoint, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
    guard let urlRequest = urlRequest(from: endpoint) else {
      assert(false, "The url request from endpoint should always be unwrappable")
      completion(nil, nil, APIClientError.cannotGenerateUrlRequestProperly)
      return
    }
    
    #if DEBUG
    let date = Date()
    if logLevel != .none, let url = urlRequest.url {
      print("****** Request \(url.absoluteString)")
    }
    #endif
    
    let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      #if DEBUG
      if self.logLevel != .none,
        let url = urlRequest.url, let response = response as? HTTPURLResponse,
        let responseCode = ResponseCode(rawValue: abs(response.statusCode/100))
      {
        print("****** RESPONSE \(responseCode.summary) \(responseCode.emoji) \(response.statusCode) - Time \(date.timeIntervalSinceNow * -1)s -> \(url.absoluteString)")
        
        if self.logLevel == .debug, let data = data, let dataStringified = String(data: data, encoding: .utf8) {
          print("****** Response description is \(responseCode.description). Data stringified -> \(dataStringified)")
        }
      }
      #endif
      
      DispatchQueue.main.async {
        completion(data, response, error)
      }
    }

    DispatchQueue.global().async {
      task.resume()
    }
  }
}
