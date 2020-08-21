//
//  RootRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class RootRouterImpl {
    private let presentationScene: PresentationScene
    private let navigationScene: NavigationScene
    private let signUpBuilder: SignUpBuilder
    private let dashboardBuilder: DashboardBuilder

    init(
        presentationScene: PresentationScene,
        navigationScene: NavigationScene,
        signUpBuilder: SignUpBuilder,
        dashboardBuilder: DashboardBuilder
    ) {
        self.presentationScene = presentationScene
        self.navigationScene = navigationScene
        self.signUpBuilder = signUpBuilder
        self.dashboardBuilder = dashboardBuilder
    }
}

// MARK: - RootRouter implementation

extension RootRouterImpl: RootRouter {
    func showSignUp() {
        let signUpView = signUpBuilder.build()
        navigationScene.play(view: signUpView, animated: false, completion: nil)
    }
    
    func showDashboard() {
        let dashboardView = dashboardBuilder.build()
        dashboardView.modalPresentationStyle = .fullScreen
        presentationScene.play(view: dashboardView, animated: false, completion: nil)
    }
}
