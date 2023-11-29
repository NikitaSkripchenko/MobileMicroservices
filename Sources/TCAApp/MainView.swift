import SwiftUI
import SharedServices
import ComposableArchitecture

struct MainView: View {
    let store: StoreOf<MainFeature>
    @Dependency(\.uiService) var uiService
    
    var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: { .path($0) })) {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                VStack {
                    if viewStore.isLoading {
                        ProgressView("Loading...")
                    } else if let data = viewStore.data {
                        List {
                            ForEach(data.indices, id: \.self) { index in
                                let element = data[index]
                                NavigationLink(state: DetailFeature.State(id: element.id)) {
                                    VStack(alignment: .leading) {
                                        Text(element.title)
                                            .foregroundStyle(.green)
                                        Text(element.sponsor.name)
                                    }
                                }
                                .buttonStyle(.borderless)
                            }
                        }
                        .navigationTitle("TCA List")
                    } else if let error = viewStore.error {
                        Text("Error: \(error.localizedDescription)")
                    }
                }
                .onAppear {
                    viewStore.send(.loadData)
                }
            }
            
        }
    destination: {store in
        DetailView(store: store)
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(store: Store(initialState: MainFeature.State(), reducer: {
            MainFeature()
        }))
    }
}
