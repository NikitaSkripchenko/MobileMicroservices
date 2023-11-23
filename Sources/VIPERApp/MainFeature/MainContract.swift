//
//  MainContract.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation

class SomeDataMock {
    
}

protocol MainView: AnyObject {
    func setViewModel(_ viewModel: MainViewModel)
}

protocol MainEventHandler: AnyObject {
    func didLoadView()
    func didTapOnItem(with id: Int)
    func retrieveData()
}

protocol MainInteractorInput: AnyObject {
    func retrieveList() -> Result<SomeDataMock, Error>
}

protocol MainInteractorOutput: AnyObject {
    /* noop */
}

protocol MainWireframe: AnyObject {
    func openItem(id: Int)
}
