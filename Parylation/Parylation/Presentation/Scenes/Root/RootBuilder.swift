//
//  RootBuilder.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit
import ParylationDomain
import Moya

final class RootBuilderImpl {
    private let dependency: RootDependency
    
    init(dependency: RootDependency) {
        self.dependency = dependency
    }
}

// MARK: - RootBuilder implementation

extension RootBuilderImpl: RootBuilder {
    func build() -> UIViewController {
        let view = RootView()
//        let userRepository = UserRepositoryImpl(provider: MoyaProvider<ParylationAPI>())
        let authorizationUseCase = AuthorizationUseCaseImpl(
            authorizedUserRepository: AuthorizedUserRepositoryImpl(realm: dependency.realm)
        )
        let component = RootComponent(
            window: dependency.window,
            authorizationUseCase: authorizationUseCase
        )
        let welcomeBuilder = WelcomeBuilderImpl(dependency: component)
        let dashboardBuilder = DashboardBuilderImpl(dependency: component)
        let interactor = RootInteractorImpl(authorizationUseCase: authorizationUseCase)
        let router = RootRouterImpl(
            presentationScene: PresentationScene(presentingViewController: view),
            welcomeBuilder: welcomeBuilder,
            dashboardBuilder: dashboardBuilder
        )
        let viewModel = RootViewModelImpl(
            interactor: interactor,
            router: router
        )
        view.viewModel = viewModel
        return view
    }
}
