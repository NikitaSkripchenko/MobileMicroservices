import SwiftUI
import SharedServices
import ComposableArchitecture

struct ContentView: View {
    let store: StoreOf<MainFeature>
    @Dependency(\.uiService) var uiService
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                if viewStore.isLoading {
                    ProgressView("Loading...")
                } else if let data = viewStore.data {
                    List {
                        ForEach(data, id: \.id) { element in
                            VStack(alignment: .leading) {
                                Text(element.title)
                                    .foregroundStyle(.green)
                                Text(element.sponsor.name)
                            }
                        }
                    }
                } else if let error = viewStore.error {
                    Text("Error: \(error.localizedDescription)")
                }
            }
            .onAppear {
                viewStore.send(.loadData)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store(initialState: MainFeature.State(), reducer: {
            MainFeature()
        }))
    }
}
