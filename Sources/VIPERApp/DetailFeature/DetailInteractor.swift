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
    
    //networking service
    init() {
    }
}

extension DetailInteractor: DetailInteractorInput {
    
    func retrieveItem(for id: Int) -> Result<SomeDataMockDetail, Error> {
        // call network here
        return .success(.init())
    }
}
