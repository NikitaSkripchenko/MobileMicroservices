//
//  MainInteractor.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import SharedServices

class MainInteractor {
    weak var delegate: MainInteractorOutput!
    var networkService: NetworkService
    
    //networking service
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension MainInteractor: MainInteractorInput {
    func retrieveList() {
        let requestType = APIRequest.getInitiatives
        
        networkService.fetchData(for: requestType) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let responseData = String(data: data, encoding: .utf8)
                print("Data received: \(responseData ?? "")")
                
                // Update data property
                do {
                    let initiatives = try JSONDecoder().decode(Initiatives.self, from: data)
                    self.delegate.didReceiveList(with: initiatives)
                } catch {
                    self.delegate.didReceivedError()
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
//        return .success(.init())
    }
}
