//
//  SignUpRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SignUpRouterImpl {
    private let navigationScene: NavigationScene
    private let signInBuilder: SignInBuilder
    
    private weak var signUpListener: (SignUpListener & SignInListener)?
    
    init(
        navigationScene: NavigationScene,
        signInBuilder: SignInBuilder,
        signUpListener: SignUpListener & SignInListener
    ) {
        self.navigationScene = navigationScene
        self.signInBuilder = signInBuilder
        self.signUpListener = signUpListener
    }
}

// MARK: - SignUpRouter implementation

extension SignUpRouterImpl: SignUpRouter {
    func showSignIn() {
        guard let signUpListener = signUpListener else { return }
        let signInView = signInBuilder.build(listener: signUpListener)
        navigationScene.set(views: [signInView], animated: true, completion: nil)
    }
    
    func finishSignUp() {
        signUpListener?.onSignUpFinish()
    }
}
