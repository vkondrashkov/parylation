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
    typealias Context = AuthContext & MainContext
    
    private let context: Context
    
    init(context: Context) {
        self.context = context
    }
}

// MARK: - WelcomeBuilder implementation

extension WelcomeBuilderImpl: WelcomeBuilder {
    func build() -> UIViewController {
        let view = WelcomeView()
        let authNavigationController = UINavigationController()
        authNavigationController.setNavigationBarHidden(true, animated: false)
        let signUpBuilder = SignUpBuilderImpl(context: context)
        let signInBuilder = SignInBuilderImpl(context: context)
        let dashboardBuilder = DashboardBuilderImpl(context: context)
        let interactor = WelcomeInteractorImpl()
        let router = WelcomeRouterImpl(
            window: context.window,
            presentingViewController: view,
            navigationController: authNavigationController,
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
