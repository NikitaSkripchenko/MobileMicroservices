import SwiftUI
import SharedServices
import ComposableArchitecture

struct InitiativesView: View {
    let store: StoreOf<InitiativeFeature>
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
                                ZStack {
                                    let element = data[index]
                                    uiService.createInitiativeCard(initiative: element)
                                    NavigationLink(state: DetailFeature.State(id: element.id)) {
                                        EmptyView()
                                    }
                                    .opacity(0)
                                    
                                }
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
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

struct InitiativesView_Previews: PreviewProvider {
    static var previews: some View {
        InitiativesView(store: Store(initialState: InitiativeFeature.State(), reducer: {
            InitiativeFeature()
        }))
    }
}
