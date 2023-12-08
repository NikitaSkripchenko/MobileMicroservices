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

//struct DetailView_preview: PreviewProvider {
//    static var previews: some View {
//        DetailView(viewModel: .init(itemID: "3f8a5eee-ff1e-4af9-bc11-37d5cd4fe9fd"))
//    }
//}
