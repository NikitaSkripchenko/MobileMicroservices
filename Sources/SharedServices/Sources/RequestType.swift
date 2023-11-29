//
//  RequestType.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 28.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation

public enum RequestType: String {
    case get
    case post
}

public protocol Requestable {
    var path: String { get }
    var method: RequestType { get }
}

public enum APIRequest: Requestable {
    case getInitiatives
    case getInitiative(id: String)

    public var path: String {
        switch self {
        case .getInitiatives:
            return "/v1/initiatives"
        case .getInitiative(let id):
            return "/v1/initiatives/\(id)"
        }
    }

    public var method: RequestType {
        switch self {
        case .getInitiatives, .getInitiative:
            return .get
        }
    }
}
