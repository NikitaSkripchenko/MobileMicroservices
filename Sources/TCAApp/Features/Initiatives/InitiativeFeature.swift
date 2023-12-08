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
    @Dependency(\.networkService) var networkService
    
    struct State: Equatable {
        static func == (lhs: MainFeature.State, rhs: MainFeature.State) -> Bool {
            lhs.data == rhs.data
        }
        
        var isLoading: Bool = false
        var data: Initiatives?
        var error: Error?
        @PresentationState var openDetail: DetailFeature.State?
        var path = StackState<DetailFeature.State>()
    }
    
    enum Action {
        case loadData
        case dataLoaded(Initiatives)
        case dataLoadingFailed
        case path(StackAction<DetailFeature.State, DetailFeature.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadData:
                let request = APIRequest.getInitiatives
                state.isLoading = true
                return .run { send in
                    let data = try await networkService.fetchData(for: request)
                    do {
                        let initiatives = try JSONDecoder().decode(Initiatives.self, from: data)
                        await send(.dataLoaded(initiatives))
                    }
                    catch {
                        await send(.dataLoadingFailed)
                    }
                }
            case let .dataLoaded(data):
                state.isLoading = false
                state.data = data
                return .none
            case .dataLoadingFailed:
                state.isLoading = false
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: /Action.path) {
            DetailFeature()
        }
    }
}
