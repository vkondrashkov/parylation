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
    private let homeNavigationScene: NavigationScene
    private let homeBuilder: HomeBuilder
    
    private let settingsNavigationScene: NavigationScene
    private let settingsBuilder: SettingsBuilder
    
    init(
        tabBarController: UITabBarController,
        homeNavigationScene: NavigationScene,
        homeBuilder: HomeBuilder,
        settingsNavigationScene: NavigationScene,
        settingsBuilder: SettingsBuilder
    ) {
        self.tabBarController = tabBarController
        self.homeNavigationScene = homeNavigationScene
        self.homeBuilder = homeBuilder
        self.settingsNavigationScene = settingsNavigationScene
        self.settingsBuilder = settingsBuilder
    }
}

// MARK: - DashboardRouter implementation

extension DashboardRouterImpl: DashboardRouter {
    func showTabs() {
        let homeView = homeBuilder.build()
        homeNavigationScene.set(views: [homeView], animated: false, completion: nil)
        
        let settingsView = settingsBuilder.build()
        settingsNavigationScene.set(views: [settingsView], animated: false, completion: nil)
    }
}
