//
//  WelcomeRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

final class WelcomeRouterImpl {
    private let presentationScene: PresentationScene
    private let navigationScene: NavigationScene
    private let signUpBuilder: SignUpBuilder
    
    init(
        presentationScene: PresentationScene,
        navigationScene: NavigationScene,
        signUpBuilder: SignUpBuilder
    ) {
        self.presentationScene = presentationScene
        self.navigationScene = navigationScene
        self.signUpBuilder = signUpBuilder
    }
}

// MARK: - WelcomeRouter implementation

extension WelcomeRouterImpl: WelcomeRouter {
    func showSignUp() {
        let signUpView = signUpBuilder.build()
        navigationScene.set(views: [signUpView], animated: false, completion: nil)
//        presentationScene.play(view: signUpView, animated: true, completion: nil)
        presentationScene.play(scene: navigationScene, animated: true, completion: nil)
    }
    
    func showSignIn() {

    }
}
