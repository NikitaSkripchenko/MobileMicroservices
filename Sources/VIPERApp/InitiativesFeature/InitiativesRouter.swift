//
//  MainRouter.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import UIKit

class InitiativesRouter {
    weak var mainViewController: UIViewController!
}

extension InitiativesRouter: InitiativesWireframe {
    func openItem(id: String) {
        let detailScreen = DetailScreen().build(id: id)
        mainViewController.navigationController?.pushViewController(detailScreen, animated: true)
    }
}
