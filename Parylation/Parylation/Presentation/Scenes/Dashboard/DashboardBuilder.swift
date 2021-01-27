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
    typealias Context = MainContext
    
    private let context: Context
    
    init(context: Context) {
        self.context = context
    }
}

// MARK: - DashboardBuilder implementation

extension DashboardBuilderImpl: DashboardBuilder {
    func build(listener: DashboardListener?) -> UIViewController {
        let view = DashboardView()
        
        let homeNavigationController = UINavigationController()
        let homeTabBarImage = Asset.dashboardHome.image
        let homeTabBarItem = UITabBarItem(
            title: nil,
            image: homeTabBarImage,
            selectedImage: nil
        )
        homeTabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
        homeNavigationController.tabBarItem = homeTabBarItem
        
        let calendarNavigationController = UINavigationController()
        calendarNavigationController.setNavigationBarHidden(true, animated: false)
        let calendarTabBarImage = Asset.dashboardCalendar.image
        let calendarTabBarItem = UITabBarItem(
            title: nil,
            image: calendarTabBarImage,
            selectedImage: nil
        )
        calendarTabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
        calendarNavigationController.tabBarItem = calendarTabBarItem
        
        let settingsNavigationController = UINavigationController()
        settingsNavigationController.setNavigationBarHidden(true, animated: false)
        let profileTabBarImage = Asset.dashboardProfile.image
        let profileTabBarItem = UITabBarItem(
            title: nil,
            image: profileTabBarImage,
            selectedImage: nil
        )
        profileTabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
        settingsNavigationController.tabBarItem = profileTabBarItem
        
        let homeBuilder = HomeBuilderImpl(context: context)
        let settingsBuilder = SettingsBuilderImpl(context: context)
        
        let interactor = DashboardInteractorImpl()
        
        view.viewControllers = [homeNavigationController, calendarNavigationController, settingsNavigationController]
        
        let router = DashboardRouterImpl(
            tabBarController: view,
            homeNavigationController: homeNavigationController,
            homeBuilder: homeBuilder,
            settingsNavigationController: settingsNavigationController,
            settingsBuilder: settingsBuilder,
            listener: listener
        )
        let viewModel = DashboardViewModelImpl(
            interactor: interactor,
            router: router
        )
        view.viewModel = viewModel
        return view
    }
}
