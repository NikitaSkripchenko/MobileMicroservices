//
//  DetailViewController.swift
//  MVCApp
//
//  Created by Nikita Skrypchenko on 29.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import UIKit
import SharedServices
import SwiftUI

class DetailViewController: UIViewController {
    private let uiService: UIService!
    private let networkService: NetworkService!
    private let initiativeId: String!
    private var initiative: Initiative?
    
    init(
        initiativeId: String,
        uiService: UIService = UIServiceImpl(),
        networkService: NetworkService = DefaultNetworkService()
    ) {
        self.initiativeId = initiativeId
        self.uiService = uiService
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        retrieveItem(for: initiativeId)
    }
    
    private func setupUI() {
        guard let initiative = initiative else { return }
        view.backgroundColor = .white
        let swiftUIView = uiService.createInitiativeScreen(initiative: initiative)
        
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        hostingController.didMove(toParent: self)
    }
    
    func retrieveItem(for id: String) {
        let request = APIRequest.getInitiative(id: id)
        networkService.fetchData(for: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let responseData = String(data: data, encoding: .utf8)
                print("Data received: \(responseData ?? "")")
                
                do {
                    let initiative = try JSONDecoder().decode(Initiative.self, from: data)
                    self.initiative = initiative
                    DispatchQueue.main.async {
                        self.setupUI()
                    }
                } catch {
                    presentError()
                }
                
            case .failure:
                presentError()
            }
        }
    }
    
    private func presentError() {
        print("Error")
    }
    
}
