import UIKit
import SwiftUI
import ComposableArchitecture

@main
struct testApp: App {
    
    init() {
        UITabBar.appearance().standardAppearance = UITabBarAppearance.whiteAppearance()
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.whiteAppearance()
    }
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    InitiativesView(store: Store(initialState: InitiativeFeature.State(), reducer: {
                        InitiativeFeature()
                    }))
                }
                .tabItem {
                    Label("Ініціативи", systemImage: "checklist")
                }

                NavigationView {
                    SponsorsView(store: Store(initialState: SponsorsFeature.State(), reducer: {
                        SponsorsFeature()
                    }))
                }
                .tabItem {
                    Label("Фонди", systemImage: "person.3.fill")
                }
            }
            .tint(.green)
        }
    }
}
