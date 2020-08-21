//
//  WelcomeRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

final class WelcomeRouterImpl {
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

// MARK: - WelcomeRouter implementation

extension WelcomeRouterImpl: WelcomeRouter {
    func showSignUp() {
        let signUpView = signUpBuilder.build()
        navigationScene.play(view: signUpView, animated: true, completion: nil)
    }
    
    func showSignIn() {

    }
}
