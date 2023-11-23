//
//  MainPresenter.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation

class DetailPresenter {
    weak var view: DetailView?
    var router: DetailWireframe!
    var interactor: DetailInteractor!
}

extension DetailPresenter: DetailEventHandler {
    func didLoadView() {
        //add loading view
    }
    
    func didTapBackButton() {
        router.goBack()
    }
    
    func retrieveData(for id: Int) {
        switch interactor.retrieveItem(for: id) {
        case let .success(data):
            DispatchQueue.main.async { [weak self] in
                // remove loading view
                self?.view?.setViewModel(DetailViewModel())
            }
        case let .failure(error):
            DispatchQueue.main.async { [weak self] in
                // remove loading view
                self?.view?.setViewModel(DetailViewModel())//but error
            }
        }
       
    }
}

extension DetailPresenter: DetailInteractorOutput {
    
}
