//
//  MainViewModel.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 23.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import SharedServices

struct MainViewModel {
    let list: Initiatives
    
    init(list: Initiatives) {
        self.list = list
    }
}
