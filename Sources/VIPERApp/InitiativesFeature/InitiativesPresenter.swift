//
//  MainPresenter.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import SharedServices

class InitiativesPresenter {
    weak var view: InitiativesView?
    var router: InitiativesWireframe!
    var interactor: InitiativesInteractor!
}

extension InitiativesPresenter: InitiativesEventHandler {
    func didLoadView() {
        interactor.retrieveList()
    }
    
    func didTapOnItem(with id: String) {
        router.openItem(id: id)
    }
}

extension InitiativesPresenter: InitiativesInteractorOutput {
    func didReceiveList(with initiatives: Initiatives) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.setErrorViewStatus(.hidden)
            self?.view?.setViewModel(InitiativesViewModel(list: initiatives))
        }
    }
    
    func didReceivedError() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.setErrorView(ErrorViewModel.initiativesError(""), visible: true)
        }
    }
}
