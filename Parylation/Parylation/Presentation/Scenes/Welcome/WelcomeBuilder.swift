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
        let component = WelcomeComponent(navigationController: dependency.navigationController)
        let signUpBuilder = SignUpBuilderImpl(dependency: component)
        let interactor = WelcomeInteractorImpl()
        let router = WelcomeRouterImpl(
            navigationScene: NavigationScene(navigationController: dependency.navigationController),
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
