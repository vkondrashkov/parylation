//
//  RootRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class RootRouterImpl {
    private let navigationController: UINavigationController

    init(
        navigationController: UINavigationController
        // builder
    ) {
        self.navigationController = navigationController
    }
}

// MARK: - RootRouter implementation

extension RootRouterImpl: RootRouter {
    func showAuth() { }
    
    func showDashboard() { }
}
