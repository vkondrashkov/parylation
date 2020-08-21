//
//  SignUpBuilder.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit
import ParylationDomain

final class SignUpBuilderImpl {
    private let dependency: SignUpDependency
    
    init(dependency: SignUpDependency) {
        self.dependency = dependency
    }
}

// MARK: - SignUpBuilder implementation

extension SignUpBuilderImpl: SignUpBuilder {
    func build() -> UIViewController {
        let view = SignUpView()
        let interactor = SignUpInteractorImpl()
        let router = SignUpRouterImpl(
            navigationScene: NavigationScene(navigationController: dependency.authNavigationController)
        )
        let viewModel = SignUpViewModelImpl(
            interactor: interactor,
            router: router
        )
        view.viewModel = viewModel
        return view
    }
}
