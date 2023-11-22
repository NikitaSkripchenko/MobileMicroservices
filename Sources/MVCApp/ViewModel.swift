import SwiftUI
import SharedServices

class ViewModel: ObservableObject {
    let button: AnyView

    init(uiService: UIService = UIServiceImpl()) {
        button = uiService.createButton(title: "Tap Me") {
            // Handle button tap
            print("Button tapped!")
        }
    }
}
