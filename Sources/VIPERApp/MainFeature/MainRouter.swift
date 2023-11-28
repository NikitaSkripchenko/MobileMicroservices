//
//  MainRouter.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import UIKit

class MainRouter {
    weak var mainViewController: UIViewController!
}

extension MainRouter: MainWireframe {
    func openItem(id: String) {
        let detailScreen = DetailScreen().build()
        mainViewController.navigationController?.pushViewController(detailScreen, animated: true)
    }
    
}
