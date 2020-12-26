//
// 
//  TaskRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import UIKit

final class TaskRouterImpl {
    private weak var viewController: UIViewController?
    private let alertBuilder: AlertBuilder

    init(
        viewController: UIViewController,
        alertBuilder: AlertBuilder
    ) {
        self.viewController = viewController
        self.alertBuilder = alertBuilder
    }
}

// MARK: - TaskRouter implementation

extension TaskRouterImpl: TaskRouter {
    func showTaskEdit(taskId: String, completion: (() -> Void)?) {

    }

    func showAlert(info: AlertViewInfo) {
        let alertView = alertBuilder.build(info: info)
        viewController?.present(alertView, animated: true, completion: nil)
    }
    
    func terminate() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
