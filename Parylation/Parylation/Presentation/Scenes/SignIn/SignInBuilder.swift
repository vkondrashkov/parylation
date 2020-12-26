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
    typealias Context = SignInContainer & SignUpContainer
    
    private let context: Context
    
    init(context: Context) {
        self.context = context
    }
}

// MARK: - SignInBuilder implementation

extension SignInBuilderImpl: SignInBuilder {
    func build(listener: (SignInListener & SignUpListener)?) -> UIViewController {
        let view = SignInView()
        let signUpBuilder = SignUpBuilderImpl(context: context)
        let interactor = SignInInteractorImpl(
            authorizationUseCase: context.authorizationUseCase
        )
        let router = SignInRouterImpl(
            view: view,
            signUpBuilder: signUpBuilder,
            signInListener: listener
        )
        let viewModel = SignInViewModelImpl(
            interactor: interactor,
            router: router
        )
        view.viewModel = viewModel
        return view
    }
}
