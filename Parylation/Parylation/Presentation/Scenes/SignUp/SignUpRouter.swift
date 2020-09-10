//
//  SignUpRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SignUpRouterImpl {
    private weak var view: UIViewController?
    private let signInBuilder: SignInBuilder
    
    private weak var signUpListener: (SignUpListener & SignInListener)?
    
    init(
        view: UIViewController,
        signInBuilder: SignInBuilder,
        signUpListener: (SignUpListener & SignInListener)?
    ) {
        self.view = view
        self.signInBuilder = signInBuilder
        self.signUpListener = signUpListener
    }
}

// MARK: - SignUpRouter implementation

extension SignUpRouterImpl: SignUpRouter {
    func showSignIn() {
        let signInView = signInBuilder.build(listener: signUpListener)
        view?.navigationController?.setViewControllers([signInView], animated: true)
    }
    
    func finishSignUp() {
        signUpListener?.onSignUpFinish()
    }
}
