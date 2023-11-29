//
//  MainInteractor.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import SharedServices

class DetailInteractor {
    weak var delegate: DetailInteractorOutput!
    var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension DetailInteractor: DetailInteractorInput {
    
    func retrieveItem(for id: String) {
        // call network here
        let request = APIRequest.getInitiative(id: id)
        networkService.fetchData(for: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let responseData = String(data: data, encoding: .utf8)
                print("Data received: \(responseData ?? "")")
                
                do {
                    let initiative = try JSONDecoder().decode(Initiative.self, from: data)
                    self.delegate.didReceive(initiative)
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
