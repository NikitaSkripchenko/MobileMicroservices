//
//  MainContract.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import SharedServices

protocol MainView: ErrorViewPresentable {
    func setViewModel(_ viewModel: MainViewModel)
    func setErrorView(_ viewModel: ErrorViewModel, visible: Bool)
}

protocol MainEventHandler: AnyObject {
    func didLoadView()
    func didTapOnItem(with id: String)
    func retrieveData()
}

protocol MainInteractorInput: AnyObject {
    func retrieveList()
}

protocol MainInteractorOutput: AnyObject {
    /* noop */
    func didReceiveList(with initiatives: Initiatives)
    func didReceivedError()
}

protocol MainWireframe: AnyObject {
    func openItem(id: String)
}
