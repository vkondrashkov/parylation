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
    
    init(
        view: UIViewController,
        taskBuilder: TaskBuilder
    ) {
        self.view = view
        self.taskBuilder = taskBuilder
    }
}

// MARK: - HomeRouter implementation

extension HomeRouterImpl: HomeRouter {
    func showTask(taskId: String) {
        let taskView = taskBuilder.build(taskId: taskId)
        taskView.hidesBottomBarWhenPushed = true
        view?.navigationController?.pushViewController(taskView, animated: true)
    }
}
