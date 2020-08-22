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
    
    init(
        navigationScene: NavigationScene,
        signInBuilder: SignInBuilder
    ) {
        self.navigationScene = navigationScene
        self.signInBuilder = signInBuilder
    }
}

// MARK: - SignUpRouter implementation

extension SignUpRouterImpl: SignUpRouter {
    func showSignIn() {
        let signInView = signInBuilder.build()
        navigationScene.set(views: [signInView], animated: true, completion: nil)
    }
}
