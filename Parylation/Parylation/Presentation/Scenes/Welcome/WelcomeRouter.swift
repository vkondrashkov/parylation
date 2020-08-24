//
//  WelcomeRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

final class WelcomeRouterImpl {
    private let windowScene: WindowScene
    private let presentationScene: PresentationScene
    private let navigationScene: NavigationScene
    private let signUpBuilder: SignUpBuilder
    private let signInBuilder: SignInBuilder
    private let dashboardBuilder: DashboardBuilder
    
    init(
        windowScene: WindowScene,
        presentationScene: PresentationScene,
        navigationScene: NavigationScene,
        signUpBuilder: SignUpBuilder,
        signInBuilder: SignInBuilder,
        dashboardBuilder: DashboardBuilder
    ) {
        self.windowScene = windowScene
        self.presentationScene = presentationScene
        self.navigationScene = navigationScene
        self.signUpBuilder = signUpBuilder
        self.signInBuilder = signInBuilder
        self.dashboardBuilder = dashboardBuilder
    }
}

// MARK: - WelcomeRouter implementation

extension WelcomeRouterImpl: WelcomeRouter {
    func showSignUp() {
        let signUpView = signUpBuilder.build(listener: self)
        navigationScene.set(views: [signUpView], animated: false, completion: nil)
        presentationScene.play(scene: navigationScene, animated: true, completion: nil)
    }
    
    func showSignIn() {
        let signInView = signInBuilder.build(listener: self)
        navigationScene.set(views: [signInView], animated: false, completion: nil)
        presentationScene.play(scene: navigationScene, animated: true, completion: nil)
    }
    
    func showDashboard() {
        let dashboardView = dashboardBuilder.build()
        windowScene.play(view: dashboardView, animated: false, completion: nil)
    }
}

// MARK: - SignInListener implementation

extension WelcomeRouterImpl: SignInListener {
    func onSignInFinish() {
        presentationScene.stop(animated: true, completion: { [weak self] in
            self?.showDashboard()
        })
    }
}

// MARK: - SignUpListener implementation

extension WelcomeRouterImpl: SignUpListener {
    func onSignUpFinish() {
        presentationScene.stop(animated: true, completion: { [weak self] in
            self?.showDashboard()
        })
    }
}
