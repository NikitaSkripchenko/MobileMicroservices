//
//  MainContract.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import SharedServices

protocol DetailView: ErrorViewPresentable {
    func setViewModel(_ viewModel: DetailViewModel)
}

protocol DetailEventHandler: AnyObject {
    func didLoadView()
    func retrieveData(for id: String)
}

protocol DetailInteractorInput: AnyObject {
    func retrieveItem(for id: String)
}

protocol DetailInteractorOutput: AnyObject {
    func didReceive(_ item: Initiative)
    func didReceivedError()
}

protocol DetailWireframe: AnyObject {
    func goBack()
}
