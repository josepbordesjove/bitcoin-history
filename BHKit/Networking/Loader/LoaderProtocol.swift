//
//  LoaderStore.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 01/12/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public protocol LoaderProtocol {
  func loadDataTask(urlRequest: URLRequest, logLevel: APIClientLogLevel, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}
