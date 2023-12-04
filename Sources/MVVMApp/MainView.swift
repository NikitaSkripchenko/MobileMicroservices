import SwiftUI
import SharedServices

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @Environment(\.uiService) var uiService: UIService
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.loadingState {
                case .loading:
                    ProgressView("Loading...")
                case let .loaded(data):
                    List {
                        ForEach(data) { element in
                            ZStack {
                                CardView(element: element)
                                NavigationLink (
                                    destination: DetailView(viewModel: DetailViewModel(itemID: element.id))
                                ) { EmptyView() }
                                    .opacity(0)
                            }
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        }
                    }
                    .navigationTitle("Ініціативи")
                case let .error(error):
                    Text(error.localizedDescription)
                }
            }
            .onAppear {
                viewModel.loadList()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}


struct CardView: View {
    let element: Initiative
    @Environment(\.uiService) var uiService: UIService
    
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
                    
                    HStack {
                        Image(systemName: "location")
                        Text(element.directions[0].town)
                            .font(.callout)
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
                    uiService.createProgressView(status: element.status, progress: element.progress)
                }
                .padding()
            }
//            .cornerRadius(18)
            
        }
    }
}
