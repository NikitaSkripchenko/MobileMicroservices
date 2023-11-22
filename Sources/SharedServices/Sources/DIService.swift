//
//  DIService.swift
//  Opora
//
//  Created by Nikita Skrypchenko on 12.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation

class DIContainer {
    static let shared = DIContainer()

    private init() {}

    private let uiService: UIService = UIServiceImpl()
//    private let userService: UserService = UserServiceImpl()
//    private let itemService: ItemService = ItemServiceImpl()


    func resolveUIService() -> UIService {
        return uiService
    }
}
