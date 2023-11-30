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
                            
                            NavigationLink (
                                destination: DetailView(viewModel: DetailViewModel(itemID: element.id))
                            ) {
                                VStack(alignment: .leading) {
                                    Text(element.title)
                                        .foregroundStyle(.green)
                                    Text(element.sponsor.name)
                                }
                            }
                        }
                    }
                    .navigationTitle("MVVM List")
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
