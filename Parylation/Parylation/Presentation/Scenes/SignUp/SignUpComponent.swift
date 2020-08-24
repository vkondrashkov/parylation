//
//  SignUpComponent.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit
import ParylationDomain

final class SignUpComponent: SignInDependency {
    private let navigationController: UINavigationController
    let authorizationUseCase: AuthorizationUseCase
    
    var authNavigationController: UINavigationController {
        return navigationController
    }
    
    init(
        navigationController: UINavigationController,
        authorizationUseCase: AuthorizationUseCase
    ) {
        self.navigationController = navigationController
        self.authorizationUseCase = authorizationUseCase
    }
}
