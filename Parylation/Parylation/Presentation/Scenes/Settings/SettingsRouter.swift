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
    private var window: UIWindow?

    init(
        view: UIViewController,
        alertBuilder: AlertBuilder
    ) {
        self.view = view
        self.alertBuilder = alertBuilder
    }
}

// MARK: - SettingsRouter implementation

extension SettingsRouterImpl: SettingsRouter {
    func showAlert(info: AlertViewInfo) {
        let alertView = alertBuilder.build(info: info)
        alertView.selfDisplay()
    }

    func terminate() {
        view?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
