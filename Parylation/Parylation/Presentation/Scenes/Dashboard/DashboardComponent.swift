//
//  DashboardComponent.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class DashboardComponent {
    let parent: UIViewController
    let homeNavigationController: UINavigationController
    let calendarNavigationController: UINavigationController
    let profileNavigationController: UINavigationController
    
    init(
        parent: UIViewController,
        homeNavigationController: UINavigationController,
        calendarNavigationController: UINavigationController,
        profileNavigationController: UINavigationController
    ) {
        self.parent = parent
        self.homeNavigationController = homeNavigationController
        self.calendarNavigationController = calendarNavigationController
        self.profileNavigationController = profileNavigationController
    }
}
