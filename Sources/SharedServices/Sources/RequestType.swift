//
//  RequestType.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 28.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation

enum RequestType: String {
    case get
    case post
    // Add more request types as needed
}

protocol Requestable {
    var path: String { get }
    var method: RequestType { get }
    // Add more properties as needed
}

enum APIRequest: Requestable {
    case getInitiatives
    case getInitiative(id: String)
    // Add more cases as needed

    var path: String {
        switch self {
        case .getInitiatives:
            return "/v1/initiatives"
        case .getInitiative(let id):
            return "/v1/initiatives/\(id)"
        }
    }

    var method: RequestType {
        switch self {
        case .getInitiatives, .getInitiative:
            return .get
        }
    }
}
