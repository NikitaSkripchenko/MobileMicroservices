import UIKit
import SwiftUI
import SharedServices

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
                    InitiativesView(viewModel: InitiativesViewModel())
                }
                .tabItem {
                    Label("Ініціативи", systemImage: "checklist")
                }

                NavigationView {
                    SponsorsView(viewModel: SponsorsViewModel())
                }
                .tabItem {
                    Label("Фонди", systemImage: "person.3.fill")
                }
            }
            .tint(.green)
        }
    }
}
