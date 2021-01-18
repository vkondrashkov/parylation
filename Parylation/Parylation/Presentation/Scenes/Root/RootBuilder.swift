//
//  RootBuilder.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit
import ParylationDomain
import Moya

final class RootBuilderImpl {
    typealias Context = AppContext
    
    private let context: Context
    
    init(context: Context) {
        self.context = context
    }
}

// MARK: - RootBuilder implementation

extension RootBuilderImpl: RootBuilder {
    func build() -> UIViewController {
        let view = RootView()
        let welcomeBuilder = WelcomeBuilderImpl(context: context)
        let dashboardBuilder = DashboardBuilderImpl(context: context)
        let interactor = RootInteractorImpl(
            authorizationService: context.authorizationService,
            pushNotificationsService: context.pushNotificationsService
        )
        let router = RootRouterImpl(
            view: view,
            welcomeBuilder: welcomeBuilder,
            dashboardBuilder: dashboardBuilder
        )
        let viewModel = RootViewModelImpl(
            interactor: interactor,
            router: router
        )
        view.viewModel = viewModel
        return view
    }
}
