//
//  MainScreen.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import UIKit
import SharedServices
import Swinject

class InitiativesScreen {
    
    let uiService: UIService
    let networkService: NetworkService
    
    init(resolver: Resolver = DIContainer.container,
         uiService: UIService = UIServiceImpl(),
         networkService: NetworkService = DefaultNetworkService()
        ) {
        self.uiService = uiService
        self.networkService = networkService
    }
    
    func build() -> UIViewController {
        let router = InitiativesRouter()
        let presenter = InitiativesPresenter()
        let interactor = InitiativesInteractor(networkService: networkService)
        let view = InitiativesViewController()
        
        view.eventHandler = presenter
        router.mainViewController = view
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        interactor.delegate = presenter
        
        return view
    }
}
