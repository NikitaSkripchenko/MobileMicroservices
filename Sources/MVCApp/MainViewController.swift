//
//  MainViewController.swift
//  MVCApp
//
//  Created by Nikita Skrypchenko on 22.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import SharedServices
import Swinject

class MainViewController: UIViewController {
    private let uiService: UIService
    private let resolver: Resolver

    init(resolver: Resolver = DIContainer.container,
         uiService: UIService = UIServiceImpl()) {
        self.resolver = resolver
        self.uiService = uiService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Register UserService in DI
        let button = uiService.createButton(title: "Tap me MVC") {
            print("Button tapped!")
        }
        
        let vc = UIHostingController(rootView: button)
        let swiftuiView = vc.view!
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        
        // 2
        // Add the view controller to the destination view controller.
        addChild(vc)
        view.addSubview(swiftuiView)
        
        // 3
        // Create and activate the constraints for the swiftui's view.
        NSLayoutConstraint.activate([
            swiftuiView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swiftuiView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        // 4
        // Notify the child view controller that the move is complete.
        vc.didMove(toParent: self)
    }
}
