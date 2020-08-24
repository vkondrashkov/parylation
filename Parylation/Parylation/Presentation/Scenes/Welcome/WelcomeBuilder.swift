//
//  WelcomeBuilder.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit
import ParylationDomain

final class WelcomeBuilderImpl {
    private let dependency: WelcomeDependency
    
    init(dependency: WelcomeDependency) {
        self.dependency = dependency
    }
}

// MARK: - WelcomeBuilder implementation

extension WelcomeBuilderImpl: WelcomeBuilder {
    func build() -> UIViewController {
        let view = WelcomeView()
        let authNavigationController = UINavigationController()
        authNavigationController.setNavigationBarHidden(true, animated: false)
//        authNavigationController.interactivePopGestureRecognizer?.delegate = nil
        let component = WelcomeComponent(
            navigationController: authNavigationController,
            authorizationUseCase: dependency.authorizationUseCase
        )
        let signUpBuilder = SignUpBuilderImpl(dependency: component)
        let signInBuilder = SignInBuilderImpl(dependency: component)
        let dashboardBuilder = DashboardBuilderImpl(dependency: component)
        let interactor = WelcomeInteractorImpl()
        let router = WelcomeRouterImpl(
            windowScene: WindowScene(window: dependency.window),
            presentationScene: PresentationScene(presentingViewController: view),
            navigationScene: NavigationScene(navigationController: authNavigationController),
            signUpBuilder: signUpBuilder,
            signInBuilder: signInBuilder,
            dashboardBuilder: dashboardBuilder
        )
        let viewModel = WelcomeViewModelImpl(
            interactor: interactor,
            router: router
        )
        view.viewModel = viewModel
        return view
    }
}
