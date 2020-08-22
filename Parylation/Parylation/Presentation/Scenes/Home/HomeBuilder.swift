//
//  HomeBuilder.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit
import ParylationDomain

final class HomeBuilderImpl {
    private let dependency: HomeDependency
    
    init(dependency: HomeDependency) {
        self.dependency = dependency
    }
}

// MARK: - HomeBuilder implementation

extension HomeBuilderImpl: HomeBuilder {
    func build() -> UIViewController {
        let view = HomeView()
        let component = HomeComponent(navigationController: dependency.homeNavigationController)
        let interactor = HomeInteractorImpl()
        let router = HomeRouterImpl(
            navigationScene: NavigationScene(navigationController: dependency.homeNavigationController)
        )
        let viewModel = HomeViewModelImpl(
            interactor: interactor,
            router: router
        )
        view.viewModel = viewModel
        return view
    }
}
