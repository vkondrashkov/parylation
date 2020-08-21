//
//  SignUpRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class SignUpRouterImpl {
    private let navigationScene: NavigationScene
    
    init(navigationScene: NavigationScene) {
        self.navigationScene = navigationScene
    }
}

// MARK: - SignUpRouter implementation

extension SignUpRouterImpl: SignUpRouter {
    func showSignIn() {
        // build
        
    }
}
