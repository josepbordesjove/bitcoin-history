//
//  APIClientType.swift
//  iqb-network-package
//
//  Created by Josep Bordes Jové on 22/11/2019.
//

import Foundation


protocol APIClientType {
    func loadDataTask(endpoint: Endpoint, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension APIClientType {
    // MARK: Load endpoints

    internal func load<T: Decodable>(endpoint: Endpoint, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        self.loadDataTask(endpoint: endpoint) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(APIClientError.cannotDecodeJson))
                return
            }

            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}
