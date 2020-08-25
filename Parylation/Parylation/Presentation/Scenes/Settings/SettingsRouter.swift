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
    private let navigationScene: NavigationScene

    init(
        navigationScene: NavigationScene
    ) {
        self.navigationScene = navigationScene
    }
}

// MARK: - SettingsRouter implementation

extension SettingsRouterImpl: SettingsRouter { }
