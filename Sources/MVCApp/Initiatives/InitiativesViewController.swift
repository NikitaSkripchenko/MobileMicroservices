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

class InitiativesViewController: UIViewController {
    private let uiService: UIService
    private let resolver: Resolver
    private var tableView: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    private var data: Initiatives = []
    private let networkService: NetworkService

    init(resolver: Resolver = DIContainer.container,
         uiService: UIService = UIServiceImpl(),
         networkService: NetworkService = DefaultNetworkService()
    ) {
        self.resolver = resolver
        self.uiService = uiService
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
        self.title = "MVC List"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = UITableView.automaticDimension
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
        
        loadList()
    }
    
    private func loadList() {
        let requestType = APIRequest.getInitiatives
        
        networkService.fetchData(for: requestType) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let responseData = String(data: data, encoding: .utf8)
                print("Data received: \(responseData ?? "")")
                
                do {
                    let initiatives = try JSONDecoder().decode(Initiatives.self, from: data)
                    self.data = initiatives
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    presentError()
                }
                
            case .failure(let error):
                print("Error: \(error)")
                presentError()
            }
        }
    }
    
    private func presentError() {
        print("error")
    }
}

extension InitiativesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = data[indexPath.row]
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
        let detailViewController = DetailViewController(initiativeId: data[indexPath.row].id)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
