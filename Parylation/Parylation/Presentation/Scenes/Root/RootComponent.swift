//
//  RootComponent.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class RootComponent: DashboardDependency, SignUpDependency {
    private let navigationController: UINavigationController
    
    var authNavigationController: UINavigationController {
        return navigationController
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
