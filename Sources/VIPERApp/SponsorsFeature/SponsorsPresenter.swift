//
//  SponsorsPresenter.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.12.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import SharedServices

class SponsorsPresenter {
    weak var view: SponsorsView?
    var router: SponsorsWireframe!
    var interactor: SponsorsInteractor!
}

extension SponsorsPresenter: SponsorsEventHandler {
    func didLoadView() {
        interactor.retrieveList()
    }
    
    func didTapOnItem(with id: String) {
        
    }
}

extension SponsorsPresenter: SponsorsInteractorOutput {
    func didReceiveList(with sponsors: [Sponsor]) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.setErrorViewStatus(.hidden)
            self?.view?.setViewModel(SponsorsViewModel(list: sponsors))
        }
    }
    
    func didReceivedError() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.setErrorView(ErrorViewModel.initiativesError(""), visible: true)
        }
    }
}

