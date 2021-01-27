//
//  WelcomeRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class WelcomeRouterImpl {
    private weak var window: UIWindow?
    private let navigationController: UINavigationController
    private weak var view: UIViewController?
    private let signUpBuilder: SignUpBuilder
    private let signInBuilder: SignInBuilder

    private weak var listener: WelcomeListener?
    
    init(
        window: UIWindow,
        view: UIViewController,
        signUpBuilder: SignUpBuilder,
        signInBuilder: SignInBuilder,
        listener: WelcomeListener?
    ) {
        self.window = window
        self.view = view
        self.signUpBuilder = signUpBuilder
        self.signInBuilder = signInBuilder
        self.listener = listener

        navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: - WelcomeRouter implementation

extension WelcomeRouterImpl: WelcomeRouter {
    func showSignUp() {
        let signUpView = signUpBuilder.build(listener: self)
        navigationController.setViewControllers([signUpView], animated: false)
        view?.present(navigationController, animated: true, completion: nil)
    }
    
    func showSignIn() {
        let signInView = signInBuilder.build(listener: self)
        navigationController.setViewControllers([signInView], animated: false)
        view?.present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - SignInListener implementation

extension WelcomeRouterImpl: SignInListener {
    func onSignInFinish() {
        view?.dismiss(animated: true, completion: { [weak self] in
            self?.listener?.onAuthorizationFinish()
        })
    }
}

// MARK: - SignUpListener implementation

extension WelcomeRouterImpl: SignUpListener {
    func onSignUpFinish() {
        view?.dismiss(animated: true, completion: { [weak self] in
            self?.listener?.onAuthorizationFinish()
        })
    }
}
