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
        let homeTabBarImage = UIImage(named: "dashboard-home")
        let homeTabBarItem = UITabBarItem(
            title: nil,
            image: homeTabBarImage,
            selectedImage: nil
        )
        homeTabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
        homeNavigationController.tabBarItem = homeTabBarItem
        
        let calendarNavigationController = UINavigationController()
        calendarNavigationController.setNavigationBarHidden(true, animated: false)
        let calendarTabBarImage = UIImage(named: "dashboard-calendar")
        let calendarTabBarItem = UITabBarItem(
            title: nil,
            image: calendarTabBarImage,
            selectedImage: nil
        )
        calendarTabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
        calendarNavigationController.tabBarItem = calendarTabBarItem
        
        let settingsNavigationController = UINavigationController()
        settingsNavigationController.setNavigationBarHidden(true, animated: false)
        let profileTabBarImage = UIImage(named: "dashboard-profile")
        let profileTabBarItem = UITabBarItem(
            title: nil,
            image: profileTabBarImage,
            selectedImage: nil
        )
        profileTabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
        settingsNavigationController.tabBarItem = profileTabBarItem
        
        let component = DashboardComponent(
            parent: view,
            homeNavigationController: homeNavigationController,
            calendarNavigationController: calendarNavigationController,
            settingsNavigationController: settingsNavigationController
        )
        
        let homeBuilder = HomeBuilderImpl(dependency: component)
        let settingsBuilder = SettingsBuilderImpl(dependency: component)
        
        let interactor = DashboardInteractorImpl()
        
        view.viewControllers = [homeNavigationController, calendarNavigationController, settingsNavigationController]
        
        let router = DashboardRouterImpl(
            tabBarController: view,
            homeNavigationScene: NavigationScene(navigationController: homeNavigationController),
            homeBuilder: homeBuilder,
            settingsNavigationScene: NavigationScene(navigationController: settingsNavigationController),
            settingsBuilder: settingsBuilder
        )
        let viewModel = DashboardViewModelImpl(
            interactor: interactor,
            router: router
        )
        view.viewModel = viewModel
        return view
    }
}
