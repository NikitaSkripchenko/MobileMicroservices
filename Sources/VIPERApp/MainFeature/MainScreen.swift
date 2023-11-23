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

class MainScreen {
    
    let uiService: UIService
    
    init(resolver: Resolver = DIContainer.container,
         uiService: UIService = UIServiceImpl()) {
        self.uiService = uiService
    }
    
    func build() -> UIViewController {
        let router = MainRouter()
        let presenter = MainPresenter()
        let interactor = MainInteractor()
        let view = MainViewController()
        
        view.eventHandler = presenter
        router.mainViewController = view
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        interactor.delegate = presenter
        
        return view
    }
}
