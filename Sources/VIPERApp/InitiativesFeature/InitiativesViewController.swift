//
//  MainViewController.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import SharedServices
import Swinject

class InitiativesViewController: UIViewController {
    var eventHandler: InitiativesEventHandler!
    var tableView: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    var emptyStateController: EmptyStateController!
    var viewModel: InitiativesViewModel?
    private let uiService: UIService
    private let resolver: Resolver
    
    init(resolver: Resolver = DIContainer.container,
         uiService: UIService = UIServiceImpl()
    ) {
        self.resolver = resolver
        self.uiService = uiService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        eventHandler.didLoadView()
    }
    
    private func setupUI() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setEmptyStateDataModel(with model: ErrorViewModel) {
        emptyStateController = EmptyStateController(data: model)
        emptyStateController.customInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        if emptyStateController.parentView == nil {
            emptyStateController.parentView = self.view
        }
    }
}

extension InitiativesViewController: InitiativesView {
    func setErrorView(_ viewModel: ErrorViewModel, visible: Bool) {
        if visible {
            setEmptyStateDataModel(with: viewModel)
            emptyStateController.showOverlay()
        } else {
            emptyStateController.hideOverlay()
        }
    }
    
    func setViewModel(_ viewModel: InitiativesViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
}

extension InitiativesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = viewModel?.list else { return 0 }
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let element = viewModel?.list[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.contentConfiguration = UIHostingConfiguration {
            uiService.createInitiativeCard(initiative: element)
        }
        cell.selectionStyle = .none
        return cell
    }
}

extension InitiativesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = viewModel?.list else { return }
        eventHandler.didTapOnItem(with: data[indexPath.row].id)
    }
}
