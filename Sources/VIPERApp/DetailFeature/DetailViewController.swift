//
//  MainViewController.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import UIKit
import SharedServices
import SwiftUI

class DetailViewController: UIViewController {
    var eventHandler: DetailEventHandler!
    let uiService: UIService!
    let initiativeId: String!
    
    init(initiativeId: String, uiService: UIService) {
        self.initiativeId = initiativeId
        self.uiService = uiService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        eventHandler.retrieveData(for: initiativeId)
    }
    
    private func setupUI(with detailViewModel: DetailViewModel) {
        // Creating SwiftUI view
        view.backgroundColor = .white
        let swiftUIView = uiService.createInitiativeScreen(initiative: detailViewModel.initiative)
        
        // Wrapping SwiftUI view in a UIHostingController
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Adding UIHostingController as a child view controller
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        // Setting constraints
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        hostingController.didMove(toParent: self)
    }
    
}

extension DetailViewController: DetailView {
    func setViewModel(_ viewModel: DetailViewModel) {
        setupUI(with: viewModel)
    }
}
