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
    private let welcomeBuilder: WelcomeBuilder
    private let dashboardBuilder: DashboardBuilder

    init(
        presentationScene: PresentationScene,
        welcomeBuilder: WelcomeBuilder,
        dashboardBuilder: DashboardBuilder
    ) {
        self.presentationScene = presentationScene
        self.welcomeBuilder = welcomeBuilder
        self.dashboardBuilder = dashboardBuilder
    }
}

// MARK: - RootRouter implementation

extension RootRouterImpl: RootRouter {
    func showWelcome() {
        let welcomeView = welcomeBuilder.build()
        welcomeView.modalPresentationStyle = .fullScreen
        presentationScene.play(view: welcomeView, animated: false, completion: nil)
    }
    
    func showDashboard() {
        let dashboardView = dashboardBuilder.build()
        dashboardView.modalPresentationStyle = .fullScreen
        presentationScene.play(view: dashboardView, animated: false, completion: nil)
    }
}
