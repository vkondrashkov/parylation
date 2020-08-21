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
    
    init(
        navigationScene: NavigationScene,
        signUpBuilder: SignUpBuilder
    ) {
        self.navigationScene = navigationScene
        self.signUpBuilder = signUpBuilder
    }
}

// MARK: - SignInRouter implementation

extension SignInRouterImpl: SignInRouter {
    func showSignUp() {
        let signUpView = signUpBuilder.build()
        navigationScene.set(views: [signUpView], animated: true, completion: nil)
    }
}
