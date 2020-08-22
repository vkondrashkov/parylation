//
//  SignInBuilder.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit
import ParylationDomain

final class SignInBuilderImpl {
    private let dependency: SignInDependency
    
    init(dependency: SignInDependency) {
        self.dependency = dependency
    }
}

// MARK: - SignInBuilder implementation

extension SignInBuilderImpl: SignInBuilder {
    func build() -> UIViewController {
        let view = SignInView()
        let component = SignInComponent(navigationController: dependency.authNavigationController)
        let signUpBuilder = SignUpBuilderImpl(dependency: component)
        let interactor = SignInInteractorImpl()
        let router = SignInRouterImpl(
            navigationScene: NavigationScene(navigationController: dependency.authNavigationController),
            signUpBuilder: signUpBuilder
        )
        let viewModel = SignInViewModelImpl(
            interactor: interactor,
            router: router
        )
        view.viewModel = viewModel
        return view
    }
}
