//
//  MainViewController.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import UIKit

class FakeEntity {
    let id: Int
    init(id: Int) {
        self.id = id
    }
}

class MainViewController: UIViewController {
    var eventHandler: MainEventHandler!
    var tableView: UITableView = UITableView()
    var emptyStateController: EmptyStateController!
    var viewModel: MainViewModel?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "List"
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

extension MainViewController: MainView {
    func setErrorView(_ viewModel: ErrorViewModel, visible: Bool) {
        if visible {
            setEmptyStateDataModel(with: viewModel)
            emptyStateController.showOverlay()
        } else {
            emptyStateController.hideOverlay()
        }
    }
    
    func setViewModel(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = viewModel?.list else { return 0 }
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = viewModel?.list else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "\(data[indexPath.row].title)"
        content.secondaryText = "\(data[indexPath.row].sponsor.name)"
        content.textProperties.color = .systemGreen

        cell.contentConfiguration = content
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = viewModel?.list else { return }
        eventHandler.didTapOnItem(with: data[indexPath.row].id)
    }
}
