//
// 
//  CalendarRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 27.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//
//

import UIKit

final class CalendarRouterImpl {
    private weak var view: UIViewController?
    private let taskEditBuilder: TaskEditBuilder

    init(
        view: UIViewController,
        taskEditBuilder: TaskEditBuilder
    ) {
        self.view = view
        self.taskEditBuilder = taskEditBuilder
    }
}

// MARK: - CalendarRouter implementation

extension CalendarRouterImpl: CalendarRouter {
    func showTaskCreation() {
        let editView = taskEditBuilder.build(taskId: nil)
        view?.present(editView, animated: true, completion: nil)
    }
}
