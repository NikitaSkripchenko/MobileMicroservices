//
//  SponsorsViewModel.swift
//  MVVMApp
//
//  Created by Nikita Skrypchenko on 06.12.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import Combine
import SharedServices
import Swinject

class SponsorsViewModel: ObservableObject {
    enum LoadingState {
        case loading
        case loaded(items: [Sponsor])
        case error(Error)
    }
    
    @Published var selectedSponsor: Int?
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
        let requestType = APIRequest.getSponsors
        networkService.fetchData(for: requestType) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                do {
                    let initiatives = try JSONDecoder().decode([Sponsor].self, from: data)
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
    
    func itemTapped(id: Int) {
        selectedSponsor = id
    }
}
