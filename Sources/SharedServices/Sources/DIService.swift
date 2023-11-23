//
//  DIService.swift
//  Opora
//
//  Created by Nikita Skrypchenko on 12.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import Swinject

public class DIContainer {
    public static let container: Container = {
        let container = Container()
        
        
        container.register(UIService.self) { _ in
            UIServiceImpl()
        }

        return container
    }()
}
