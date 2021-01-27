//
// 
//  CalendarRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 27.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//
//

import UIKit

final class CalendarRouterImpl {
    private weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }
}

// MARK: - CalendarRouter implementation

extension CalendarRouterImpl: CalendarRouter { }
