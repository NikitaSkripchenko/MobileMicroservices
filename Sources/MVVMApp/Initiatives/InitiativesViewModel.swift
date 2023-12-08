import SwiftUI
import SharedServices
import Combine
import Swinject

class InitiativesViewModel: ObservableObject {
    enum LoadingState {
        case loading
        case loaded(items: Initiatives)
        case error(Error)
    }
    
    @Published var selectedItem: Item?
    @Published var loadingState: LoadingState = .loading
    private var cancellables: Set<AnyCancellable> = []
    
    private let uiService: UIService
    private let networkService: NetworkService
    
    init(resolver: Resolver = DIContainer.container,
         uiService: UIService = UIServiceImpl(),
         networkService: NetworkService = DefaultNetworkService()
    ) {
        self.uiService = uiService
        self.networkService = networkService
    }

    func loadList() {
        let requestType = APIRequest.getInitiatives
        networkService.fetchData(for: requestType) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                do {
                    let initiatives = try JSONDecoder().decode(Initiatives.self, from: data)
                    DispatchQueue.main.async {
                        self.loadingState = .loaded(items: initiatives)
                    }
                } catch(let error) {
                    DispatchQueue.main.async {
                        self.loadingState = .error(error)
                    }
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    self.loadingState = .error(error)
                }
            }
        }
    }
    
    func itemTapped(item: Item) {
        selectedItem = item
    }
}
