//
//  DetailView.swift
//  TCAApp
//
//  Created by Nikita Skrypchenko on 29.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct DetailView: View {
    @Dependency (\.uiService) var uiService
    let store: StoreOf<DetailFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                if viewStore.isLoading {
                    ProgressView("Loading...")
                } else if let data = viewStore.data {
                    uiService.createInitiativeScreen(initiative: data)
                }
            }.onAppear(perform: {
                store.send(.loadData)
            })
        }
    }
}
