//
//  DashboardBuilder.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class DashboardBuilderImpl {
    private let dependency: DashboardDependency
    
    init(dependency: DashboardDependency) {
        self.dependency = dependency
    }
}

// MARK: - DashboardBuilder implementation

extension DashboardBuilderImpl: DashboardBuilder {
    func build() -> UIViewController {
        let view = DashboardView()
        let component = DashboardComponent(parent: view)
        let interactor = DashboardInteractorImpl()
        
        let tabBarController = UITabBarController()
        let router = DashboardRouterImpl(tabBarController: tabBarController)
        let viewModel = DashboardViewModelImpl(
            interactor: interactor,
            router: router
        )
        view.viewModel = viewModel
        return view
    }
}
