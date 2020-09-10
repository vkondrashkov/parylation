//
//  HomeRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class HomeRouterImpl {
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
}

// MARK: - HomeRouter implementation

extension HomeRouterImpl: HomeRouter { }
