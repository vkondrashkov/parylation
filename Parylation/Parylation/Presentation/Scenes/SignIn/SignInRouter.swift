//
//  SignInRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SignInRouterImpl {
    private let navigationScene: NavigationScene
    private let signUpBuilder: SignUpBuilder
    
    private weak var signInListener: (SignInListener & SignUpListener)?
    
    init(
        navigationScene: NavigationScene,
        signUpBuilder: SignUpBuilder,
        signInListener: SignInListener & SignUpListener
    ) {
        self.navigationScene = navigationScene
        self.signUpBuilder = signUpBuilder
        self.signInListener = signInListener
    }
}

// MARK: - SignInRouter implementation

extension SignInRouterImpl: SignInRouter {
    func showSignUp() {
        guard let signInListener = signInListener else { return }
        let signUpView = signUpBuilder.build(listener: signInListener)
        navigationScene.set(views: [signUpView], animated: true, completion: nil)
    }
    
    func finishSignIn() {
        signInListener?.onSignInFinish()
    }
}
