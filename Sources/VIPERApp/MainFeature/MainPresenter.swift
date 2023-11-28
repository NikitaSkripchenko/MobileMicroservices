//
//  MainPresenter.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import SharedServices

class MainPresenter {
    weak var view: MainView?
    var router: MainWireframe!
    var interactor: MainInteractor!
}

extension MainPresenter: MainEventHandler {
    func didLoadView() {
        retrieveData()
    }
    
    func didTapOnItem(with id: String) {
        router.openItem(id: id)
    }
    
    func retrieveData() {
        interactor.retrieveList()
    }
}

extension MainPresenter: MainInteractorOutput {
    func didReceiveList(with initiatives: Initiatives) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.setErrorViewStatus(.hidden)
            self?.view?.setViewModel(MainViewModel(list: initiatives))
        }
    }
    
    func didReceivedError() {
        DispatchQueue.main.async { [weak self] in
            // remove loading view
            self?.view?.setErrorView(ErrorViewModel.initiativesError(""), visible: true)
        }
    }
}
