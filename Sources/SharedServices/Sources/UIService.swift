import SwiftUI

public protocol UIService {
    func createButton(title: String, action: @escaping () -> Void) -> AnyView
    func createInitiativeScreen(initiative: Initiative) -> AnyView
}

public class UIServiceImpl: UIService {
    public init() { }
    
    public func createButton(title: String, action: @escaping () -> Void) -> AnyView {
        return AnyView(
            Button(action: action) {
                Text(title)
                    .background(Color.red)
            }
                
        )
    }
    
    public func createInitiativeScreen(initiative: Initiative) -> AnyView {
        struct StatusProgressView: View {
            let status: String
            let progress: Int

            var body: some View {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(status)
                            .foregroundColor(.green)
                            .font(.subheadline)
                        
                        Spacer()
                        
                        ProgressView(value: Double(progress), total: 100)
                            .accentColor(.green)
                            .frame(width: 100)
                    }
                }
            }
        }

        struct SponsorView: View {
            let sponsor: Sponsor

            var body: some View {
                Text("Sponsor: \(sponsor.name)")
                    .font(.headline)
                    .padding(.horizontal)
            }
        }

        struct ContactsView: View {
            let contacts: [Contact]

            var body: some View {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Contacts:")
                        .font(.headline)

                    ForEach(contacts, id: \.self) { contact in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(contact.firstName) \(contact.lastName)")
                            Text("Phone: \(contact.phones.first?.number ?? "") (\(contact.phones.first?.types.first ?? ""))")
                            Text("Email: \(contact.email)")
                            if let link = contact.links.first {
                                Text("Link: \(link.url)")
                                    .foregroundColor(.blue)
                                    .underline()
                            }
                        }
                    }
                }
            }
        }

        struct DirectionsView: View {
            let directions: [Direction]

            var body: some View {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Directions:")
                        .font(.headline)

                    ForEach(directions, id: \.self) { direction in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Type: \(direction.directionsType)")
                            if let street = direction.street {
                                Text("Street: \(street)")
                            }
                            Text("Town: \(direction.town)")
                            Text("Directions: \(direction.directions)")
                            if let office = direction.office {
                                Text("Office: \(office)")
                            }
                            if let recipient = direction.recipient {
                                Text("Recipient: \(recipient.firstName) \(recipient.lastName)")
                            }
                        }
                        .background(Color.secondary.opacity(0.5))
                        .cornerRadius(8)
                        .padding(.vertical, 4)
                    }
                }
            }
        }

        struct ItemsView: View {
            let items: [Item]

            var body: some View {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Items:")
                        .font(.headline)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(items, id: \.self) { item in
                                ItemCardView(item: item)
                            }
                        }
                        .padding(.all)
                    }
                }
            }
        }

        struct ItemCardView: View {
            let item: Item

            var body: some View {
                VStack(alignment: .leading, spacing: 8) {
                    if let mediaURL = URL(string: "\(Constants.baseURL)/v1/media/\(item.media)") {
                        AsyncImage(url: mediaURL)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120)
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary.opacity(0.5), lineWidth: 1)
                            )
                    }
                
                // Title, Quantity, and Status Bar
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                        Text(item.title)
                            .font(.headline)
                            .lineLimit(1)
                        Spacer()
                        Button(action: {
                            // Add button action
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.accentColor)
                        }
                        
                    }
                    
                    Text("Quantity: \(item.current)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Text("Status:")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        StatusProgressView(status: "\(item.target)", progress: item.current)
                    }
                }
                
                Spacer()
                
                // Add button in the right upper corner
                
            }
                .padding(.all)
            
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 0)
        }
    }
        
        return AnyView(
            ScrollView {
                //                Media images
                if let mediaURL = URL(string: "\(Constants.baseURL)/v1/media/\(initiative.media)") {
                    AsyncImage(url: mediaURL)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .cornerRadius(8)
                        .padding()
                }
                VStack(alignment: .leading, spacing: 16) {
                    Text(initiative.title)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Text(initiative.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding()
                    
                    StatusProgressView(status: initiative.status, progress: initiative.progress)
                        .padding()
                    
                    SponsorView(sponsor: initiative.sponsor)
                        .padding()
                    
                    ContactsView(contacts: initiative.contacts)
                        .padding()
                    
                    DirectionsView(directions: initiative.directions)
                        .padding()
                    
                    ItemsView(items: initiative.items)
                        .padding()
                    
                    
                }
            }
                .background(Color.white)
                .navigationBarTitle("", displayMode: .inline)
        )
    }
}


struct InitiativeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UIServiceImpl().createInitiativeScreen(initiative: .init(id: "", title: "title", description: "description", media: "", status: "1", isUrgent: true, progress: 1, sponsor: .init(id: "", userName: "sponsor name", name: "name"), contacts: [], directions: [], items: [.init(title: "item", description: "desc", media: "", unit: "kg", target: 10, current: 1)]))
        }
    }
}
