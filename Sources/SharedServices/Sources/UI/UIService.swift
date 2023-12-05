import SwiftUI

public protocol UIService {
    func createButton(title: String, action: @escaping () -> Void) -> AnyView
    func createInitiativeScreen(initiative: Initiative) -> AnyView
    func createProgressView(status: String, progress: Int) -> AnyView
    func createInitiativeCard(initiative: Initiative) -> AnyView
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
    
    public func createProgressView(status: String, progress: Int) -> AnyView {
        return AnyView (
            SmallStatusProgressView(status: status, progress: progress)
        )
    }
    
    public func createInitiativeCard(initiative: Initiative) -> AnyView {
        return AnyView (
            InitiativeCardView(element: initiative)
        )
    }
    
    public func createInitiativeScreen(initiative: Initiative) -> AnyView {
        return AnyView(
           DetailInitiativeView(initiative: initiative)
        )
    }
}


struct InitiativeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UIServiceImpl().createInitiativeScreen(initiative: .init(title: "title", description: "description", media: "", status: "1", isUrgent: true, progress: 1, sponsor: .init(id: "", userName: "sponsor name", name: "name"), contacts: [], directions: [], items: [.init(title: "item", description: "desc", media: "", unit: "kg", target: 10, current: 1)]))
        }
    }
}


struct DirectionsView: View {
    let directions: [Direction]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "location")
                    .font(.title)
                Text("Локація")
                    .font(.title)
            }
            
            ForEach(directions, id: \.self) { direction in
                VStack(alignment: .leading, spacing: 4) {
                    Text(direction.directionsType)
                        .fontWeight(.semibold)
                    
                    if let street = direction.street {
                        Text("Вулуця: \(street)")
                    }
                    
                    Text("Місто: \(direction.town)")
                    
                    Text("Вказівки: \(direction.directions)")
                    
                    if let office = direction.office {
                       
                        Text("Office: \(office)")
                    }
                    
                    if let recipient = direction.recipient {
                        
                        Text("Recipient: \(recipient.firstName) \(recipient.lastName)")
                    }
                }
                .background(Color.white)
                Divider()
            }
            .listStyle(InsetGroupedListStyle())
        }
        .padding()
    }
}

struct ItemsView: View {
    let items: [Item]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Що потрібно:")
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
                    
                    SmallStatusProgressView(status: "\(item.target)", progress: item.current)
                }
            }
            
            Spacer()
            
            
        }
        .padding(.all)
        
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 0)
    }
}
