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
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
}

// MARK: - DashboardRouter implementation

extension DashboardRouterImpl: DashboardRouter {
    func showTabs() {
        
    }
}
