//
//  SponsorCardView.swift
//  SharedServices
//
//  Created by Nikita Skrypchenko on 23.12.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import SwiftUI

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
        }
    }
}
