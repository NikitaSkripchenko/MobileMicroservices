//
//  MainViewController.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var eventHandler: DetailEventHandler!
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "List"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailViewController: DetailView {
    func setViewModel(_ viewModel: DetailViewModel) {
        //
    }
    
    
}
