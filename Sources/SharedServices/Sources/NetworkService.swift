//
//  NetworkService.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 28.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation

public protocol NetworkService {
    func fetchData(for requestType: Requestable, completion: @escaping (Result<Data, Error>) -> Void)
}

public class DefaultNetworkService: NetworkService {
    public init() { }
    public func fetchData(for requestType: Requestable, completion: @escaping (Result<Data, Error>) -> Void) {
        let request = RequestBuilder.buildRequest(for: requestType, baseURL: Constants.baseURL)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let emptyDataError = NSError(domain: "com.yourapp.network", code: 1, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])
                completion(.failure(emptyDataError))
                return
            }

            completion(.success(data))
        }.resume()
    }
}
