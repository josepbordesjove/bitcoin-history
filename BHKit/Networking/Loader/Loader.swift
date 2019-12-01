//
//  Loader.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 01/12/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

class Loader: LoaderProtocol {
  func loadDataTask(urlRequest: URLRequest, logLevel: APIClientLogLevel, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
    #if DEBUG
    let date = Date()
    if logLevel != .none, let url = urlRequest.url {
      print("****** Request \(url.absoluteString)")
    }
    #endif
    
    let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      #if DEBUG
      if logLevel != .none,
        let url = urlRequest.url, let response = response as? HTTPURLResponse,
        let responseCode = ResponseCode(rawValue: abs(response.statusCode/100))
      {
        print("****** RESPONSE \(responseCode.summary) \(responseCode.emoji) \(response.statusCode) - Time \(date.timeIntervalSinceNow * -1)s -> \(url.absoluteString)")
        
        if logLevel == .debug, let data = data, let dataStringified = String(data: data, encoding: .utf8) {
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
