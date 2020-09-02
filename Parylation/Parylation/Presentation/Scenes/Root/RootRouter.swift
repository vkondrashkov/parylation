//
//  RootRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class RootRouterImpl {
    private weak var presentingViewController: UIViewController?
    private let welcomeBuilder: WelcomeBuilder
    private let dashboardBuilder: DashboardBuilder

    init(
        presentingViewController: UIViewController,
        welcomeBuilder: WelcomeBuilder,
        dashboardBuilder: DashboardBuilder
    ) {
        self.presentingViewController = presentingViewController
        self.welcomeBuilder = welcomeBuilder
        self.dashboardBuilder = dashboardBuilder
    }
}

// MARK: - RootRouter implementation

extension RootRouterImpl: RootRouter {
    func showWelcome() {
        let welcomeView = welcomeBuilder.build()
        welcomeView.modalPresentationStyle = .fullScreen
        welcomeView.modalTransitionStyle = .crossDissolve
        presentingViewController?.present(welcomeView, animated: true, completion: nil)
    }
    
    func showDashboard() {
        let dashboardView = dashboardBuilder.build()
        dashboardView.modalPresentationStyle = .fullScreen
        dashboardView.modalTransitionStyle = .crossDissolve
        presentingViewController?.present(dashboardView, animated: true, completion: nil)
    }
}
