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
    typealias Context = AuthContext
    
    private let context: Context
    
    init(context: Context) {
        self.context = context
    }
}

// MARK: - WelcomeBuilder implementation

extension WelcomeBuilderImpl: WelcomeBuilder {
    func build(listener: WelcomeListener?) -> UIViewController {
        let view = WelcomeView()
        let signUpBuilder = SignUpBuilderImpl(context: context)
        let signInBuilder = SignInBuilderImpl(context: context)
        let interactor = WelcomeInteractorImpl()
        let router = WelcomeRouterImpl(
            window: context.window,
            view: view,
            signUpBuilder: signUpBuilder,
            signInBuilder: signInBuilder,
            listener: listener
        )
        let viewModel = WelcomeViewModelImpl(
            interactor: interactor,
            router: router
        )
        view.viewModel = viewModel
        return view
    }
}
