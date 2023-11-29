import UIKit
import SwiftUI
import ComposableArchitecture

@main
struct testApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(store: Store(initialState: MainFeature.State(), reducer: {
                MainFeature()
            }))
        }
    }
}
