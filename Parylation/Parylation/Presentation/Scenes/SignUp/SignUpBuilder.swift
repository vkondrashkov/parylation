//
//  SignUpBuilder.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import ParylationDomain
import UIKit

final class SignUpBuilderImpl {
    typealias Context = SignUpContainer & SignInContainer
    
    private let context: Context
    
    init(context: Context) {
        self.context = context
    }
}

// MARK: - SignUpBuilder implementation

extension SignUpBuilderImpl: SignUpBuilder {
    func build(listener: (SignUpListener & SignInListener)?) -> UIViewController {
        let view = SignUpView()
        let signInBuilder = SignInBuilderImpl(context: context)
        let interactor = SignUpInteractorImpl(
            authorizationService: context.authorizationService,
            credentialsValidatorUseCase: CredentialsValidatorUseCaseImpl()
        )
        let router = SignUpRouterImpl(
            view: view,
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
