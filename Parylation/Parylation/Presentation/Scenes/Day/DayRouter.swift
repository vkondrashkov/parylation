//
// 
//  DayRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 10.02.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//
//

import UIKit

final class DayRouterImpl {
    private weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }
}

// MARK: - DayRouter implementation

extension DayRouterImpl: DayRouter { }
