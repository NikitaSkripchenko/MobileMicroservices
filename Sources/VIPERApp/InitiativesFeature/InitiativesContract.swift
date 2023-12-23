//
//  MainContract.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import SharedServices

protocol InitiativesView: ErrorViewPresentable {
    func setViewModel(_ viewModel: InitiativesViewModel)
    func setErrorView(_ viewModel: ErrorViewModel, visible: Bool)
}

protocol InitiativesEventHandler: AnyObject {
    func didLoadView()
    func didTapOnItem(with id: String)
}

protocol InitiativesInteractorInput: AnyObject {
    func retrieveList()
}

protocol InitiativesInteractorOutput: AnyObject {
    func didReceiveList(with initiatives: Initiatives)
    func didReceivedError()
}

protocol InitiativesWireframe: AnyObject {
    func openItem(id: String)
}
