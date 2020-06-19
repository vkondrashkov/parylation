//
//  SignUpRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SignUpRouterImpl {
    private weak var navigationController: UINavigationController?
    
    init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
        
    }
}

// MARK: - SignUpRouter implementation

extension SignUpRouterImpl: SignUpRouter {
    func showSignIn() {
        // build
        
    }
}
