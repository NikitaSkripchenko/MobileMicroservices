//
//  SponsorsView.swift
//  TCAApp
//
//  Created by Nikita Skrypchenko on 23.12.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import SwiftUI
import SharedServices
import ComposableArchitecture

struct SponsorsView: View {
    let store: StoreOf<SponsorsFeature>
    @Dependency(\.uiService) var uiService
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                if viewStore.isLoading {
                    ProgressView("Loading...")
                } else if let data = viewStore.data {
                    List {
                        ForEach(data.indices, id: \.self) { index in
                            let element = data[index]
                            uiService.createSponsorCard(sponsor: element)
                        }
                    }
                } else if let error = viewStore.error {
                    Text("Error: \(error.localizedDescription)")
                }
            }
            .onAppear {
                viewStore.send(.loadData)
            }
        }
    }
}

struct SponsorsView_Previews: PreviewProvider {
    static var previews: some View {
        SponsorsView(store: Store(initialState: SponsorsFeature.State(), reducer: {
            SponsorsFeature()
        }))
    }
}

