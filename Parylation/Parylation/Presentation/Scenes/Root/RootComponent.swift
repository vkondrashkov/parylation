//
//  RootComponent.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class RootComponent: DashboardDependency, SignUpDependency {
    let parent: UIViewController
    let authNavigationController: UINavigationController
    
    init(
        parent: UIViewController,
        authNavigationController: UINavigationController
    ) {
        self.parent = parent
        self.authNavigationController = authNavigationController
    }
}
