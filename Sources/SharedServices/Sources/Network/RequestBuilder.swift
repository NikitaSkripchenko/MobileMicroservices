//
//  RequestBuilder.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 28.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation

struct RequestBuilder {
    static func buildRequest(for requestType: Requestable, baseURL: URL) -> URLRequest {
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Invalid base URL")
        }

        urlComponents.path += requestType.path

        guard let url = urlComponents.url else {
            fatalError("Invalid URL components")
        }

        var request = URLRequest(url: url)
        request.httpMethod = requestType.method.rawValue.uppercased()

        return request
    }
}
