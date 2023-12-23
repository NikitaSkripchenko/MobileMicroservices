//
//  TabBarAppearance.swift
//  MVVMApp
//
//  Created by Nikita Skrypchenko on 06.12.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import UIKit

extension UITabBarAppearance {
    public static func whiteAppearance() -> UITabBarAppearance {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        return appearance
    }
}
