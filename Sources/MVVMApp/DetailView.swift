//
//  DetailView.swift
//  MVVMApp
//
//  Created by Nikita Skrypchenko on 30.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import SwiftUI

struct DetailView: View {
    @Environment(\.uiService) var uiService
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        Group {
            switch viewModel.loadingState {
            case .loading:
                ProgressView("Loading...")
                
            case let .loaded(item):
                uiService.createInitiativeScreen(initiative: item)
            case .error(_):
                Text("Error occurred.")
            }
        }
        .onAppear {
            viewModel.loadItem()
            }
    }
}
