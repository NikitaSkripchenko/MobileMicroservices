import UIKit
import SwiftUI
import ComposableArchitecture

@main
struct testApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(initialState: MainFeature.State(), reducer: {
                MainFeature()
            }))
        }
    }
}
