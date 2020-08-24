//
//  RootComponent.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit
import ParylationDomain

final class RootComponent: DashboardDependency, WelcomeDependency {
    unowned let window: UIWindow
    let authorizationUseCase: AuthorizationUseCase
    
    init(
        window: UIWindow,
        authorizationUseCase: AuthorizationUseCase
    ) {
        self.window = window
        self.authorizationUseCase = authorizationUseCase
    }
}
