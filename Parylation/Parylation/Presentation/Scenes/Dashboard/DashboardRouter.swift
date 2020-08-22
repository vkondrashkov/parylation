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
    
    init(
        tabBarController: UITabBarController,
        homeNavigationScene: NavigationScene,
        homeBuilder: HomeBuilder
    ) {
        self.tabBarController = tabBarController
        self.homeNavigationScene = homeNavigationScene
        self.homeBuilder = homeBuilder
    }
}

// MARK: - DashboardRouter implementation

extension DashboardRouterImpl: DashboardRouter {
    func showTabs() {
        let homeView = homeBuilder.build()
        homeNavigationScene.set(views: [homeView], animated: false, completion: nil)
    }
}
