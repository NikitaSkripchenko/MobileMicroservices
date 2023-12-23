//
//  SponsorsViewModel.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.12.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import SharedServices

struct SponsorsViewModel {
    let list: [Sponsor]
    
    init(list: [Sponsor]) {
        self.list = list
    }
}
