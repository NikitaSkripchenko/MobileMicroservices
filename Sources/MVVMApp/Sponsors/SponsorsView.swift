//
//  SponsorsView.swift
//  MVVMApp
//
//  Created by Nikita Skrypchenko on 06.12.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import SwiftUI
import SharedServices

struct SponsorsView: View {
    @ObservedObject var viewModel: SponsorsViewModel
    @Environment(\.uiService) var uiService: UIService
    
    var body: some View {
        Group {
            switch viewModel.loadingState {
            case .loading:
                ProgressView("Loading...")
            case let .loaded(data):
                List {
                    ForEach(data, id: \.id) { sponsor in
                        uiService.createSponsorCard(sponsor: sponsor)
                    }
                    .padding()
                }
                .navigationTitle("Фонди")
            case .error(let error):
                Text(error.localizedDescription)
            }
        }
        .onAppear {
            viewModel.loadList()
        }
    }
}
