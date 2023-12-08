import SwiftUI
import SharedServices

struct InitiativesView: View {
    @ObservedObject var viewModel: InitiativesViewModel
    @Environment(\.uiService) var uiService: UIService
    
    var body: some View {
        
        VStack {
            switch viewModel.loadingState {
            case .loading:
                ProgressView("Loading...")
            case let .loaded(data):
                List {
                    ForEach(data) { element in
                        ZStack {
                            uiService.createInitiativeCard(initiative: element)
                            NavigationLink (
                                destination: DetailView(viewModel: DetailViewModel(itemID: element.id))
                                    .navigationBarTitleDisplayMode(.inline)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        InitiativesView(viewModel: InitiativesViewModel())
    }
}
