//
//  ContactsView.swift
//  SharedServices
//
//  Created by Nikita Skrypchenko on 05.12.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import SwiftUI

struct ContactsView: View {
    let contacts: [Contact]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "phone")
                    .font(.title)
                Text("Контакти")
                    .font(.title)
            }
            ForEach(contacts, id: \.self) { contact in
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(contact.firstName) \(contact.lastName)")
                    Text("Телефон: \(contact.phones.first?.number ?? "") (\(contact.phones.first?.types.first ?? ""))")
                    Text("Email: \(contact.email)")
                    if let link = contact.links.first {
                        Text("Посилання: \(link.platform)")
                            .foregroundColor(.blue)
                            .underline()
                                
                    }
                }
            }
        }
    }
}

struct ContactsView_Preview: PreviewProvider {
    static var previews: some View {
        ContactsView(contacts: [.init(firstName: "Name", lastName: "Second Name", phones: [.init(number: "0989787", types: [])], email: "email", links: [.init(url: "https://apple.com", platform: "FB")])])
    }
}
