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
    
    //networking service
    init() {
    }
}

extension MainInteractor: MainInteractorInput {
    func retrieveList() -> Result<SomeDataMock, Error> {
        // call network here 
        return .success(.init())
    }
}
