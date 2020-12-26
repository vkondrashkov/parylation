//
//  HomeRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class HomeRouterImpl {
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

// MARK: - HomeRouter implementation

extension HomeRouterImpl: HomeRouter {
    func showTaskCreation() {
        let editView = taskEditBuilder.build(taskId: nil)
        view?.present(editView, animated: true, completion: nil)
    }

    func showTask(taskId: String) {
        let taskView = taskBuilder.build(taskId: taskId)
        taskView.hidesBottomBarWhenPushed = true
        view?.navigationController?.pushViewController(taskView, animated: true)
    }
}
