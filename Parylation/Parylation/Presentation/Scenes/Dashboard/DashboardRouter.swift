//
//  DashboardRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class DashboardRouterImpl {
    private let tabBarController: UITabBarController
    
    private weak var homeNavigationController: UINavigationController?
    private let homeBuilder: HomeBuilder

    private weak var calendarNavigationController: UINavigationController?
    private let calendarBuilder: CalendarBuilder
    
    private weak var settingsNavigationController: UINavigationController?
    private let settingsBuilder: SettingsBuilder

    private weak var listener: DashboardListener?
    
    init(
        tabBarController: UITabBarController,
        homeNavigationController: UINavigationController,
        homeBuilder: HomeBuilder,
        calendarNavigationController: UINavigationController,
        calendarBuilder: CalendarBuilder,
        settingsNavigationController: UINavigationController,
        settingsBuilder: SettingsBuilder,
        listener: DashboardListener?
    ) {
        self.tabBarController = tabBarController
        self.homeNavigationController = homeNavigationController
        self.homeBuilder = homeBuilder
        self.calendarNavigationController = calendarNavigationController
        self.calendarBuilder = calendarBuilder
        self.settingsNavigationController = settingsNavigationController
        self.settingsBuilder = settingsBuilder
        self.listener = listener
    }
}

// MARK: - DashboardRouter implementation

extension DashboardRouterImpl: DashboardRouter {
    func showTabs() {
        let homeView = homeBuilder.build()
        homeNavigationController?.setViewControllers([homeView], animated: false)
        let calendarView = calendarBuilder.build()
        calendarNavigationController?.setViewControllers([calendarView], animated: false)
        let settingsView = settingsBuilder.build(listener: self)
        settingsNavigationController?.setViewControllers([settingsView], animated: false)
    }
}

// MARK: - SettingsListener implementation

extension DashboardRouterImpl: SettingsListener {
    func onSignOut() {
        listener?.onSignOut()
    }
}
