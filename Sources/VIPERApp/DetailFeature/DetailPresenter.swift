//
//  MainPresenter.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import SharedServices

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
    
    func retrieveData(for id: String) {
        interactor.retrieveItem(for: id)
    }
}

extension DetailPresenter: DetailInteractorOutput {
    func didReceive(_ item: Initiative) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.setErrorViewStatus(.hidden)
            self?.view?.setViewModel(DetailViewModel(initiative: item))
        }
    }
    
    func didReceivedError() {
        DispatchQueue.main.async { [weak self] in
            // remove loading view
            self?.view?.setErrorViewStatus(.visible(text: ""))
        }
    }
    
}
