//
//  TCAView.swift
//  MVCApp
//
//  Created by Nikita Skrypchenko on 22.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import SwiftUI
import Combine
import Swinject
import ComposableArchitecture
import SharedServices

struct MainFeature: Reducer {
    @Dependency(\.uiService) var uiService
    struct State: Equatable {
        var count = 0
    }
    
    enum Action {
        case buttonTapped
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .buttonTapped:
            state.count += 1
            print("logged")
            return .none
        }
    }
}

extension UIServiceImpl: DependencyKey {
    public static var liveValue: SharedServices.UIServiceImpl {
        UIServiceImpl()
    }
}

extension DependencyValues {
    var uiService: UIServiceImpl {
        get { self[UIServiceImpl.self] }
        set { self[UIServiceImpl.self] = newValue }
    }
}
