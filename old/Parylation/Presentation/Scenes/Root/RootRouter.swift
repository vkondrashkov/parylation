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
    private let signUpBuilder: SignUpBuilder
    private let dashboardBuilder: DashboardBuilder

    init(
        view: UIViewController,
        signUpBuilder: SignUpBuilder,
        dashboardBuilder: DashboardBuilder
    ) {
        self.view = view
        self.signUpBuilder = signUpBuilder
        self.dashboardBuilder = dashboardBuilder
    }
}

// MARK: - RootRouter implementation

extension RootRouterImpl: RootRouter {
    func showSignUp() {
        let signUpView = signUpBuilder.build()
        signUpView.modalPresentationStyle = .fullScreen
        view?.present(signUpView, animated: false, completion: nil)
    }
    
    func showDashboard() {
        let dashboardView = dashboardBuilder.build()
        dashboardView.modalPresentationStyle = .fullScreen
        view?.present(dashboardView, animated: false, completion: nil)
    }
}
