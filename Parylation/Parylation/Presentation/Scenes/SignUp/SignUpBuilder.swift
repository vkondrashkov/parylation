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
    typealias Context = SignUpContainer & SignInContainer
    
    private let context: Context
    
    init(context: Context) {
        self.context = context
    }
}

// MARK: - SignUpBuilder implementation

extension SignUpBuilderImpl: SignUpBuilder {
    func build(navigationController: UINavigationController, listener: SignUpListener & SignInListener) -> UIViewController {
        let view = SignUpView()
        let signInBuilder = SignInBuilderImpl(context: context)
        let interactor = SignUpInteractorImpl(
            authorizationUseCase: context.authorizationUseCase
        )
        let router = SignUpRouterImpl(
            navigationController: navigationController,
            signInBuilder: signInBuilder,
            signUpListener: listener
        )
        let viewModel = SignUpViewModelImpl(
            interactor: interactor,
            router: router
        )
        view.viewModel = viewModel
        return view
    }
}
