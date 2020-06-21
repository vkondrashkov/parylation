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
        let component = RootComponent(
            parent: view,
            authNavigationController: UINavigationController()
        )
        let signUpBuilder = SignUpBuilderImpl(dependency: component)
        let dashboardBuilder = DashboardBuilderImpl(dependency: component)
        let userRepository = UserRepositoryImpl(provider: MoyaProvider<ParylationAPI>())
        let authorizationUseCase = AuthorizationUseCaseImpl(
            authorizedUserRepository: AuthorizedUserRepositoryImpl(realm: dependency.realm)
        )
        let interactor = RootInteractorImpl(authorizationUseCase: authorizationUseCase)
        let router = RootRouterImpl(
            view: view,
            signUpBuilder: signUpBuilder,
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
