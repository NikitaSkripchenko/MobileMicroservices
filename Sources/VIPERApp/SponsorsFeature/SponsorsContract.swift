//
//  SponsorsContract.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.12.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import SharedServices

protocol SponsorsView: ErrorViewPresentable {
    func setViewModel(_ viewModel: SponsorsViewModel)
    func setErrorView(_ viewModel: ErrorViewModel, visible: Bool)
}

protocol SponsorsEventHandler: AnyObject {
    func didLoadView()
    func didTapOnItem(with id: String)
}

protocol SponsorsInteractorInput: AnyObject {
    func retrieveList()
}

protocol SponsorsInteractorOutput: AnyObject {
    func didReceiveList(with sponsors: [Sponsor])
    func didReceivedError()
}

protocol SponsorsWireframe: AnyObject {
    
}
