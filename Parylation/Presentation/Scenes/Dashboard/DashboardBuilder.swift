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
        
        let feedNavigationController = UINavigationController()
        feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: nil, selectedImage: nil)
        
        let messagesNavigationController = UINavigationController()
        messagesNavigationController.tabBarItem = UITabBarItem(title: "Messages", image: nil, selectedImage: nil)
        
        let settingsNavigationController = UINavigationController()
        settingsNavigationController.tabBarItem = UITabBarItem(title: "Settings", image: nil, selectedImage: nil)
        
        view.viewControllers = [feedNavigationController, messagesNavigationController, settingsNavigationController]
        
        let router = DashboardRouterImpl(tabBarController: view)
        let viewModel = DashboardViewModelImpl(
            interactor: interactor,
            router: router
        )
        view.viewModel = viewModel
        return view
    }
}
