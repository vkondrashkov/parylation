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
    private weak var view: UIViewController?
    private let alertBuilder: AlertBuilder

    private weak var listener: SettingsListener?

    init(
        view: UIViewController,
        alertBuilder: AlertBuilder,
        listener: SettingsListener?
    ) {
        self.view = view
        self.alertBuilder = alertBuilder
        self.listener = listener
    }
}

// MARK: - SettingsRouter implementation

extension SettingsRouterImpl: SettingsRouter {
    func showAlert(info: AlertViewInfo) {
        let alertView = alertBuilder.build(info: info)
        alertView.selfDisplay()
    }

    func terminate() {
        listener?.onSignOut()
    }
}
