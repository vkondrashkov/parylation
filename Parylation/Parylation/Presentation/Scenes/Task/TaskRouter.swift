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
import ParylationDomain

final class TaskRouterImpl {
    private weak var viewController: UIViewController?
    private let alertBuilder: AlertBuilder
    private let taskEditBuilder: TaskEditBuilder

    init(
        viewController: UIViewController,
        alertBuilder: AlertBuilder,
        taskEditBuilder: TaskEditBuilder
    ) {
        self.viewController = viewController
        self.alertBuilder = alertBuilder
        self.taskEditBuilder = taskEditBuilder
    }
}

// MARK: - TaskRouter implementation

extension TaskRouterImpl: TaskRouter {
    func showTaskEdit(task: Task, completion: (() -> Void)?) {
        let data: TaskEditData = .from(task: task)
        let editView = taskEditBuilder.build(data: data)
        viewController?.navigationController?.pushViewController(editView, animated: true)
    }

    func showAlert(info: AlertViewInfo) {
        let alertView = alertBuilder.build(info: info)
        alertView.selfDisplay()
    }
    
    func terminate() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
