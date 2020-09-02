//
//  SignUpRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SignUpRouterImpl {
    private weak var navigationController: UINavigationController?
    private let signInBuilder: SignInBuilder
    
    private weak var signUpListener: (SignUpListener & SignInListener)?
    
    init(
        navigationController: UINavigationController,
        signInBuilder: SignInBuilder,
        signUpListener: SignUpListener & SignInListener
    ) {
        self.navigationController = navigationController
        self.signInBuilder = signInBuilder
        self.signUpListener = signUpListener
    }
}

// MARK: - SignUpRouter implementation

extension SignUpRouterImpl: SignUpRouter {
    func showSignIn() {
        guard let signUpListener = signUpListener else { return }
        guard let navigationController = navigationController else { return }
        let signInView = signInBuilder.build(navigationController: navigationController, listener: signUpListener)
        navigationController.setViewControllers([signInView], animated: true)
    }
    
    func finishSignUp() {
        signUpListener?.onSignUpFinish()
    }
}
