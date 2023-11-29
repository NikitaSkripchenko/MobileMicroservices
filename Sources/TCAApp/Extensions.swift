//
//  Extensions.swift
//  TCAApp
//
//  Created by Nikita Skrypchenko on 29.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import SharedServices
import ComposableArchitecture

extension UIServiceImpl: DependencyKey {
    public static var liveValue: UIServiceImpl {
        UIServiceImpl()
    }
}

extension DefaultNetworkService: DependencyKey {
    public static var liveValue: DefaultNetworkService {
        DefaultNetworkService()
    }
}

extension DependencyValues {
    var uiService: UIServiceImpl {
        get { self[UIServiceImpl.self] }
        set { self[UIServiceImpl.self] = newValue }
    }
    
    var networkService: DefaultNetworkService {
        get { self[DefaultNetworkService.self] }
        set { self[DefaultNetworkService.self] = newValue }
    }
}
