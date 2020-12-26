//
// 
//  TaskEditRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import UIKit

final class TaskEditRouterImpl {
    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - TaskEditRouter implementation

extension TaskEditRouterImpl: TaskEditRouter {
    func terminate() {
        let result = viewController?.navigationController?.popViewController(animated: true)
        if result == nil {
            viewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
}
