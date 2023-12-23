//
//  SponsorsScreen.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.12.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import UIKit
import SharedServices
import Swinject

class SponsorsScreen {
    
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
        let router = SponsorsRouter()
        let presenter = SponsorsPresenter()
        let interactor = SponsorsInteractor(networkService: networkService)
        let view = SponsorsViewController()
        
        view.eventHandler = presenter
        router.mainViewController = view
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        interactor.delegate = presenter
        
        return view
    }
}

