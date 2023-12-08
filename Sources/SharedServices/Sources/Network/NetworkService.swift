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
        Task {
            do {
                let data = try await fetchData(for: requestType)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }
    }

    public func fetchData(for requestType: Requestable) async throws -> Data {
        let request = RequestBuilder.buildRequest(for: requestType, baseURL: Constants.baseURL)

        let (data, response) = try await URLSession.shared.data(for: request)

        return data
    }
}

