//
//  DashboardBuilder.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit
import ParylationDomain

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
        
        let homeNavigationController = UINavigationController()
        homeNavigationController.setNavigationBarHidden(true, animated: false)
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)
        
        let calendarNavigationController = UINavigationController()
        calendarNavigationController.setNavigationBarHidden(true, animated: false)
        calendarNavigationController.tabBarItem = UITabBarItem(title: "Calendar", image: nil, selectedImage: nil)
        
        let profileNavigationController = UINavigationController()
        profileNavigationController.setNavigationBarHidden(true, animated: false)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: nil, selectedImage: nil)
        
        let component = DashboardComponent(
            parent: view,
            homeNavigationController: homeNavigationController,
            calendarNavigationController: calendarNavigationController,
            profileNavigationController: profileNavigationController
        )
        let interactor = DashboardInteractorImpl()
        
        view.viewControllers = [homeNavigationController, calendarNavigationController, profileNavigationController]
        
        let router = DashboardRouterImpl(tabBarController: view)
        let viewModel = DashboardViewModelImpl(
            interactor: interactor,
            router: router
        )
        view.viewModel = viewModel
        return view
    }
}
