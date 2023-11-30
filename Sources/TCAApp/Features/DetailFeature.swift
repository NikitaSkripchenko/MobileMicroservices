//
//  DetailFeature.swift
//  TCAApp
//
//  Created by Nikita Skrypchenko on 29.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import SwiftUI
import Combine
import Swinject
import ComposableArchitecture
import SharedServices

struct DetailFeature: Reducer {
    @Dependency(\.uiService) var uiService
    @Dependency(\.networkService) var networkService
    
    struct State: Equatable {
        var isLoading: Bool = false
        var data: Initiative?
        var id: String
    }
    
    enum Action {
        case loadData
        case dataLoaded(Initiative)
        case dataLoadingFailed
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadData:
                let request = APIRequest.getInitiative(id: state.id)
                state.isLoading = true
                return .run { send in
                    let data = try await networkService.fetchData(for: request)
                    do {
                        let initiative = try JSONDecoder().decode(Initiative.self, from: data)
                        await send(.dataLoaded(initiative))
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
            }
        }
    }
}
