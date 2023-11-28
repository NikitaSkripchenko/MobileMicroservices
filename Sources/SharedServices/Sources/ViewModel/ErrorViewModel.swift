//
//  ErrorViewModel.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 28.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation

public struct ErrorViewModel {
    let title: String
    let description: String?
    let icon: IconViewModel?
    
    init(title: String, description: String?, icon: IconViewModel?) {
        self.title = title
        self.description = description
        self.icon = icon
    }
}

extension ErrorViewModel {
    static func initiativesError(_ code: String) -> ErrorViewModel {
        ErrorViewModel(title: "Error", description: "Loading of the list returned an error: \(code)", icon: nil)
    }
}
