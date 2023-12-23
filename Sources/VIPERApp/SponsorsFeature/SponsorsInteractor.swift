//
//  SponsorsInteractor.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.12.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import SharedServices

class SponsorsInteractor {
    weak var delegate: SponsorsInteractorOutput!
    var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension SponsorsInteractor: SponsorsInteractorInput {
    func retrieveList() {
        let requestType = APIRequest.getSponsors
        
        networkService.fetchData(for: requestType) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let responseData = String(data: data, encoding: .utf8)
                print("Data received: \(responseData ?? "")")
                
                do {
                    let sponsors = try JSONDecoder().decode([Sponsor].self, from: data)
                    self.delegate.didReceiveList(with: sponsors)
                } catch {
                    self.delegate.didReceivedError()
                }
                
            case .failure(let error):
                print("Error: \(error)")
                self.delegate.didReceivedError()
            }
        }
    }
}

