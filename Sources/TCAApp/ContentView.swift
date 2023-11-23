import SwiftUI
import SharedServices
import ComposableArchitecture

struct ContentView: View {
    let store: StoreOf<MainFeature>
    @Dependency(\.uiService) var uiService
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                uiService.createButton(title: "Tap me") {
                    viewStore.send(.buttonTapped)
                }
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
