//
//  ItemDetailViewModel.swift
//  MVVMApp
//
//  Created by Nikita Skrypchenko on 30.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import Combine
import Swinject
import SharedServices

class DetailViewModel: ObservableObject {
    enum LoadingState {
        case loading
        case loaded(item: Initiative)
        case error(Error)
    }
    @Published var itemID: String
    @Published var loadingState: LoadingState = .loading
    private var cancellables: Set<AnyCancellable> = []
    
    private let networkService: NetworkService
    
    init(resolver: Resolver = DIContainer.container,
         networkService: NetworkService = DefaultNetworkService(),
         itemID: String
    ) {
        self.networkService = networkService
        self.itemID = itemID
    }

    func loadItem() {
        let requestType = APIRequest.getInitiative(id: itemID)
        networkService.fetchData(for: requestType) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                do {
                    let initiative = try JSONDecoder().decode(Initiative.self, from: data)
                    DispatchQueue.main.async {
                        self.loadingState = .loaded(item: initiative)
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
}
