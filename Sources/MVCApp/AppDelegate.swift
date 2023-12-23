//
//  AppDelegate.swift
//  MVCApp
//
//  Created by Nikita Skrypchenko on 22.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation
import UIKit
import SharedServices

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)        

        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
        return true
    }
    
    private func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        
        let initiativesVC = InitiativesViewController()
        let initiativesTabBarItem = UITabBarItem(title: "Ініціативи", image: UIImage(systemName: "checklist"), tag: 0)
        initiativesVC.tabBarItem = initiativesTabBarItem
        
        let sponsorsVC = SponsorsViewController()
        let sponsorsTabBarItem = UITabBarItem(title: "Фонди", image: UIImage(systemName: "person.3.fill"), tag: 1)
        sponsorsVC.tabBarItem = sponsorsTabBarItem
        
        let controllers = [initiativesVC, sponsorsVC]
        tabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
        
        UITabBar.appearance().tintColor = .systemGreen
        UITabBar.appearance().standardAppearance = UITabBarAppearance.whiteAppearance()
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.whiteAppearance()
        
        return tabBarController
    }
}
