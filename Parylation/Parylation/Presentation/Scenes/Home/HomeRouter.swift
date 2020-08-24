//
//  HomeRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class HomeRouterImpl {
    private let navigationScene: NavigationScene
    
    init(
        navigationScene: NavigationScene
    ) {
        self.navigationScene = navigationScene
    }
}

// MARK: - HomeRouter implementation

extension HomeRouterImpl: HomeRouter { }
