//
// 
//  AlertRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import UIKit

final class AlertRouterImpl {
    private weak var viewController: UIViewController?
    private var window: UIWindow?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - AlertRouter implementation

extension AlertRouterImpl: AlertRouter {
    func show() {
        guard let viewController = viewController else { return }
        let window = UIWindow(frame: UIScreen.main.bounds)
        let container = UIViewController()
        window.rootViewController = container
        window.windowLevel =  UIWindow.Level.alert + 1
        window.makeKeyAndVisible()
        self.window = window
        container.present(viewController, animated: true, completion: nil)
    }

    func terminate() {
        viewController?.presentingViewController?.dismiss(
            animated: true,
            completion: { [weak self] in
                self?.window?.resignKey()
                self?.window = nil
            }
        )
    }
}
