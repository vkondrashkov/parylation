//
//  SignInRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SignInRouterImpl {
    private weak var view: UIViewController?
    private let signUpBuilder: SignUpBuilder
    
    private weak var signInListener: (SignInListener & SignUpListener)?
    
    init(
        view: UIViewController,
        signUpBuilder: SignUpBuilder,
        signInListener: (SignInListener & SignUpListener)?
    ) {
        self.view = view
        self.signUpBuilder = signUpBuilder
        self.signInListener = signInListener
    }
}

// MARK: - SignInRouter implementation

extension SignInRouterImpl: SignInRouter {
    func showSignUp() {
        let signUpView = signUpBuilder.build(listener: signInListener)
        view?.navigationController?.setViewControllers([signUpView], animated: true)
    }
    
    func finishSignIn() {
        signInListener?.onSignInFinish()
    }
}
