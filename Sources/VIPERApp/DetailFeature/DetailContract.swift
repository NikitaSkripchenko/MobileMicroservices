//
//  MainContract.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation

class SomeDataMockDetail {
    
}

protocol DetailView: AnyObject {
    func setViewModel(_ viewModel: DetailViewModel)
}

protocol DetailEventHandler: AnyObject {
    func didLoadView()
    func retrieveData(for id: Int)
}

protocol DetailInteractorInput: AnyObject {
    func retrieveItem(for id: Int) -> Result<SomeDataMockDetail, Error>
}

protocol DetailInteractorOutput: AnyObject {
    /* noop */
}

protocol DetailWireframe: AnyObject {
    func goBack()
}
