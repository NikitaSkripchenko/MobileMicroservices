//
//  DetailInitiativeScreen.swift
//  SharedServices
//
//  Created by Nikita Skrypchenko on 05.12.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

struct DetailInitiativeView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showSheet = false
    @State private var sheetHeight: CGFloat = .zero
    
    let initiative: Initiative
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if let mediaURL = URL(string: "\(Constants.baseURL)/v1/media/\(initiative.media)") {
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
                }
            }
            VStack(alignment: .leading, spacing: 16) {
                Text(initiative.title)
                    .font(.largeTitle)
                    .bold()
                
                Text(initiative.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    
                LargeStatusProgressView(progress: initiative.progress, maxValue: 100)
                    .padding()
                
                Divider()
                HStack {
                    Image(systemName: "person")
                    Text(initiative.sponsor.name)
                        .lineLimit(1)
                        .font(.callout)
                }
                
                if !initiative.directions.isEmpty {
                    HStack {
                        Image(systemName: "location")
                        Text(initiative.directions[0].town)
                            .font(.callout)
                    }
                }
                if initiative.isUrgent {
                    HStack {
                        Image(systemName: "bolt.circle.fill")
                        Text("Терміновий збір")
                            .font(.callout)
                    }
                    .foregroundColor(.red)
                }
                
                Divider()
                ItemsView(items: initiative.items)
            }
        }
        .safeAreaInset(edge: .bottom, content: {
            Button(action: {
                showSheet.toggle()
            }) {
                Text("Допомогти")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(15)
            }
            .padding()
        })
        .padding(.horizontal)
        .background(Color.white)
        .navigationBarTitle("", displayMode: .inline)
        .sheet(isPresented: $showSheet) {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Spacer()
                    Capsule()
                        .fill(Color.secondary)
                        .frame(width: 30, height: 3, alignment: .center)
                        .padding(10)
                    Spacer()
                }
                Spacer()
                ContactsView(contacts: initiative.contacts)
                    .padding()
                DirectionsView(directions: initiative.directions)
                Button(action: {
                    showSheet.toggle()
                }) {
                    Text("Зрозуміло")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(15)
                }
                .padding()
            }
            
            .overlay(content: {
                GeometryReader { geometry in
                    Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
                }
            })
            .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
                sheetHeight = newHeight
            }
            .presentationDetents([.height(sheetHeight)])
        }
    }
}
struct InnerHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct DetailInitiativeView_Preview: PreviewProvider {
    static var previews: some View {
        DetailInitiativeView(initiative: 
                .init(title: "title",
                      description: "descriptiondescriptiondescriptiondescriptiondescriptiondescription",
                      media:  "\(Constants.baseURL)/v1/media/b0a516bc-876a-455e-accf-d24ec5784e3f",
                      status: "1",
                      isUrgent: true,
                      progress: 40,
                      sponsor: .init(id: "", userName: "sponsor name", name: "name"),
                      contacts: [],
                      directions: [],
                      items: [.init(
                        title: "item",
                        description: "desc",
                        media: "",
                        unit: "kg",
                        target: 10,
                        current: 1)]))
    }
}
