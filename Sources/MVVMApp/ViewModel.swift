import SwiftUI
import SharedServices
import Combine
import Swinject

class MVVMViewModel: ObservableObject {
    private let uiService: UIService
    private var cancellables: Set<AnyCancellable> = []

    @Published var displayText: String = ""
    
    init(resolver: Resolver = DIContainer.container,
         uiService: UIService = UIServiceImpl()) {
        self.uiService = uiService
    }

    func buttonTapped() {
        print("login")
    }
}
