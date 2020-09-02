//
// 
//  SettingsRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/25/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import UIKit

final class SettingsRouterImpl {
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - SettingsRouter implementation

extension SettingsRouterImpl: SettingsRouter { }
