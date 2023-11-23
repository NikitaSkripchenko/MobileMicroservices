//
//  MainPresenter.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation

class MainPresenter {
    weak var view: MainView?
    var router: MainWireframe!
    var interactor: MainInteractor!
}

extension MainPresenter: MainEventHandler {
    func didLoadView() {
        //add loading view
    }
    
    func didTapOnItem(with id: Int) {
        router.openItem(id: id)
    }
    
    func retrieveData() {
        switch interactor.retrieveList() {
        case let .success(data):
            DispatchQueue.main.async { [weak self] in
                // remove loading view
                self?.view?.setViewModel(MainViewModel())
            }
        case let .failure(error):
            DispatchQueue.main.async { [weak self] in
                // remove loading view
                self?.view?.setViewModel(MainViewModel())//but error
            }
        }
       
    }
}

extension MainPresenter: MainInteractorOutput {
    
}
