//
//  RootBuilder.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class RootBuilderImpl {
    private let dependency: RootDependency
    
    init(dependency: RootDependency) {
        self.dependency = dependency
    }
}

// MARK: - RootBuilder implementation

extension RootBuilderImpl: RootBuilder {
    func build() -> UIViewController {
        let view = RootView()
        let component = RootComponent(parent: view)
        let dashboardBuilder = DashboardBuilderImpl(dependency: component)
        let userRepository = UserRepositoryImpl()
        let interactor = RootInteractorImpl(userRepository: userRepository)
        let router = RootRouterImpl(
            view: view,
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
