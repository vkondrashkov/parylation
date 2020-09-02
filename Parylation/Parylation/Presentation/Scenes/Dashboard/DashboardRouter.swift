//
//  DashboardRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class DashboardRouterImpl {
    private let tabBarController: UITabBarController
    
    private weak var homeNavigationController: UINavigationController?
    private let homeBuilder: HomeBuilder
    
    private weak var settingsNavigationController: UINavigationController?
    private let settingsBuilder: SettingsBuilder
    
    init(
        tabBarController: UITabBarController,
        homeNavigationController: UINavigationController,
        homeBuilder: HomeBuilder,
        settingsNavigationController: UINavigationController,
        settingsBuilder: SettingsBuilder
    ) {
        self.tabBarController = tabBarController
        self.homeNavigationController = homeNavigationController
        self.homeBuilder = homeBuilder
        self.settingsNavigationController = settingsNavigationController
        self.settingsBuilder = settingsBuilder
    }
}

// MARK: - DashboardRouter implementation

extension DashboardRouterImpl: DashboardRouter {
    func showTabs() {
        if let navigationController = homeNavigationController {
            let homeView = homeBuilder.build(navigationController: navigationController)
            navigationController.setViewControllers([homeView], animated: false)
        }
        if let navigationController = settingsNavigationController {
            let settingsView = settingsBuilder.build(navigationController: navigationController)
            navigationController.setViewControllers([settingsView], animated: false)
        }
    }
}
