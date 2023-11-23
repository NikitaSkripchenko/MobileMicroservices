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

class DetailScreen {
    
    let uiService: UIService
    
    init(resolver: Resolver = DIContainer.container,
         uiService: UIService = UIServiceImpl()) {
        self.uiService = uiService
    }
    
    func build() -> UIViewController {
        let router = DetailRouter()
        let presenter = DetailPresenter()
        let interactor = DetailInteractor()
        let view = DetailViewController()
        
        view.eventHandler = presenter
        router.detailViewCOntroller = view
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        interactor.delegate = presenter
        
        return view
    }
}
