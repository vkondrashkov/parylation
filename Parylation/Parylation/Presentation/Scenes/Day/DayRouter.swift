//
// 
//  DayRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 10.02.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//
//

import UIKit

final class DayRouterImpl {
    private weak var view: UIViewController?
    private let taskBuilder: TaskBuilder
    private let taskEditBuilder: TaskEditBuilder

    init(
        view: UIViewController,
        taskBuilder: TaskBuilder,
        taskEditBuilder: TaskEditBuilder
    ) {
        self.view = view
        self.taskBuilder = taskBuilder
        self.taskEditBuilder = taskEditBuilder
    }
}

// MARK: - DayRouter implementation

extension DayRouterImpl: DayRouter {
    func showTask(taskId: String) {
        let taskView = taskBuilder.build(taskId: taskId)
        taskView.hidesBottomBarWhenPushed = true
        view?.navigationController?.pushViewController(taskView, animated: true)
    }

    func showTaskEdit(data: TaskEditData) {
        let taskEditView = taskEditBuilder.build(data: data)
        taskEditView.hidesBottomBarWhenPushed = true
        view?.navigationController?.pushViewController(taskEditView, animated: true)
    }
}
