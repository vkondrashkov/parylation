//
//  SignInRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SignInRouterImpl {
    private weak var navigationController: UINavigationController?
    private let signUpBuilder: SignUpBuilder
    
    private weak var signInListener: (SignInListener & SignUpListener)?
    
    init(
        navigationController: UINavigationController,
        signUpBuilder: SignUpBuilder,
        signInListener: SignInListener & SignUpListener
    ) {
        self.navigationController = navigationController
        self.signUpBuilder = signUpBuilder
        self.signInListener = signInListener
    }
}

// MARK: - SignInRouter implementation

extension SignInRouterImpl: SignInRouter {
    func showSignUp() {
        guard let signInListener = signInListener else { return }
        guard let navigationController = navigationController else { return }
        let signUpView = signUpBuilder.build(navigationController: navigationController, listener: signInListener)
        navigationController.setViewControllers([signUpView], animated: true)
    }
    
    func finishSignIn() {
        signInListener?.onSignInFinish()
    }
}
