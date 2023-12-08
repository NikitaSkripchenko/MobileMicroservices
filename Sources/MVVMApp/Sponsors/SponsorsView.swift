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
                        SponsorCardView(sponsor: sponsor)
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

    

struct SponsorCardView: View {
    var sponsor: Sponsor

    var body: some View {
        VStack(alignment: .leading) {
            
            if let media = sponsor.media,
                let mediaURL = URL(string: "\(Constants.baseURL)/v1/media/\(media)") {
                AsyncImage(url: mediaURL) { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity, maxHeight: 200)
                .clipped()
            }

            VStack(alignment: .leading, spacing: 10) {
                Text(sponsor.name)
                    .font(.headline)
                    .bold()

                if let description = sponsor.description {
                    Text(description)
                        .font(.subheadline)
                        .lineLimit(3)
                }

                if let firstContact = sponsor.contacts?.first {
                    Text("Contact: \(firstContact.firstName) \(firstContact.lastName)")
                        .font(.caption)
                }
            }
//            .padding()
        }
//        .background(Color.white)
//        .cornerRadius(10)
//        .shadow(radius: 5)
    }
}
