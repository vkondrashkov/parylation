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

    init(
        view: UIViewController,
        taskBuilder: TaskBuilder
    ) {
        self.view = view
        self.taskBuilder = taskBuilder
    }
}

// MARK: - DayRouter implementation

extension DayRouterImpl: DayRouter {
    func showTask(taskId: String) {
        let taskView = taskBuilder.build(taskId: taskId)
        taskView.hidesBottomBarWhenPushed = true
        view?.navigationController?.pushViewController(taskView, animated: true)
    }
}
