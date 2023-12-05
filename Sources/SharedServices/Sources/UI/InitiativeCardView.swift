//
//  InitiativeCardView.swift
//  SharedServices
//
//  Created by Nikita Skrypchenko on 05.12.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import SwiftUI

struct InitiativeCardView: View {
    let element: Initiative
    
    var body: some View {
        if let mediaURL = URL(string: "\(Constants.baseURL)/v1/media/\(element.media)") {
            VStack(alignment: .leading) {
                AsyncImage(url: mediaURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height)
                
                VStack(alignment: .leading) {
                    Text(element.title)
                        .font(.title)
                        .bold()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    HStack {
                        Image(systemName: "person")
                        Text(element.sponsor.name)
                            .lineLimit(1)
                            .font(.callout)
                    }
                    
                    if !element.directions.isEmpty {
                        HStack {
                            Image(systemName: "location")
                            Text(element.directions[0].town)
                                .font(.callout)
                        }
                    }
                    if element.isUrgent {
                        HStack {
                            Image(systemName: "bolt.circle.fill")
                            Text("Терміновий збір")
                                .font(.callout)
                        }
                        .foregroundColor(.red)
                    }
                    Spacer()
                    SmallStatusProgressView(status: element.status, progress: element.progress)
                }
                .padding()
            }
        }
    }
}

struct InitiativeCardView_Previews: PreviewProvider {
    static var previews: some View {
        InitiativeCardView(element: Initiative(title: "Title", description: "Description", media: "", status: "", isUrgent: true, progress: 1, sponsor: .init(id: UUID().uuidString, userName: "Username", name: "name"), contacts: [], directions: [], items: []))
    }
}

