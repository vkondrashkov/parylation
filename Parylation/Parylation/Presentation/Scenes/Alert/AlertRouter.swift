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

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - AlertRouter implementation

extension AlertRouterImpl: AlertRouter {
    func terminate() {
        viewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
