//
//  Utils.swift
//  MVVMApp
//
//  Created by Nikita Skrypchenko on 22.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import SwiftUI
import SharedServices

struct UIServiceKey: EnvironmentKey {
    static let defaultValue: UIService = UIServiceImpl()
}

extension EnvironmentValues {
    var uiService: UIService {
        get { self[UIServiceKey.self] }
        set { self[UIServiceKey.self] = newValue }
    }
}
