//
//  RootRouterSpy.swift
//  ParylationDevTests
//
//  Created by Vladislav Kondrashkov on 7.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

@testable import ParylationDev

final class RootRouterSpy: RootRouter {
    var showWelcomeInvoked = false
    var showDashboardInvoked = false

    func showWelcome() {
        showWelcomeInvoked = true
    }

    func showDashboard() {
        showDashboardInvoked = true
    }
}
