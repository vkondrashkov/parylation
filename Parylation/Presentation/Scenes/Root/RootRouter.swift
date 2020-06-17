//
//  RootRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class RootRouterImpl {
    private weak var view: UIViewController?
    private let dashboardBuilder: DashboardBuilder

    init(
        view: UIViewController,
        dashboardBuilder: DashboardBuilder
    ) {
        self.view = view
        self.dashboardBuilder = dashboardBuilder
    }
}

// MARK: - RootRouter implementation

extension RootRouterImpl: RootRouter {
    func showAuth() { }
    
    func showDashboard() {
        let dashboardView = dashboardBuilder.build()
        dashboardView.modalPresentationStyle = .fullScreen
        view?.present(dashboardView, animated: false, completion: nil)
    }
}
