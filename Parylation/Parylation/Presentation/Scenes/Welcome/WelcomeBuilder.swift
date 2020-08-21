//
//  WelcomeBuilder.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit
import ParylationDomain

final class WelcomeBuilderImpl {
    private let dependency: WelcomeDependency
    
    init(dependency: WelcomeDependency) {
        self.dependency = dependency
    }
}

// MARK: - WelcomeBuilder implementation

extension WelcomeBuilderImpl: WelcomeBuilder {
    func build() -> UIViewController {
        let view = WelcomeView()
        let authNavigationController = UINavigationController()
        authNavigationController.setNavigationBarHidden(true, animated: false)
//        authNavigationController.interactivePopGestureRecognizer?.delegate = nil
        let component = WelcomeComponent(navigationController: authNavigationController)
        let signUpBuilder = SignUpBuilderImpl(dependency: component)
        let interactor = WelcomeInteractorImpl()
        let router = WelcomeRouterImpl(
            presentationScene: PresentationScene(presentingViewController: view),
            navigationScene: NavigationScene(navigationController: authNavigationController),
            signUpBuilder: signUpBuilder
        )
        let viewModel = WelcomeViewModelImpl(
            interactor: interactor,
            router: router
        )
        view.viewModel = viewModel
        return view
    }
}
