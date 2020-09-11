//
//  RootRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class RootRouterImpl {
    private weak var view: UIViewController?
    private let welcomeBuilder: WelcomeBuilder
    private let dashboardBuilder: DashboardBuilder

    init(
        view: UIViewController,
        welcomeBuilder: WelcomeBuilder,
        dashboardBuilder: DashboardBuilder
    ) {
        self.view = view
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
        view?.present(welcomeView, animated: true, completion: nil)
    }
    
    func showDashboard() {
        let dashboardView = dashboardBuilder.build()
        dashboardView.modalPresentationStyle = .fullScreen
        dashboardView.modalTransitionStyle = .crossDissolve
        view?.present(dashboardView, animated: true, completion: nil)
    }
}
