//
//  SponsorsFeature.swift
//  TCAApp
//
//  Created by Nikita Skrypchenko on 23.12.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import SwiftUI
import Combine
import Swinject
import ComposableArchitecture
import SharedServices

struct SponsorsFeature: Reducer {
    @Dependency(\.uiService) var uiService
    @Dependency(\.networkService) var networkService
    
    struct State: Equatable {
        static func == (lhs: SponsorsFeature.State, rhs: SponsorsFeature.State) -> Bool {
            lhs.data == rhs.data
        }
        
        var isLoading: Bool = false
        var data: [Sponsor]?
        var error: Error?
    }
    
    enum Action {
        case loadData
        case dataLoaded([Sponsor])
        case dataLoadingFailed
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadData:
                let request = APIRequest.getSponsors
                state.isLoading = true
                return .run { send in
                    let data = try await networkService.fetchData(for: request)
                    do {
                        let sponsors = try JSONDecoder().decode([Sponsor].self, from: data)
                        await send(.dataLoaded(sponsors))
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
