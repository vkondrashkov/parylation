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
    private let dayBuilder: DayBuilder

    init(
        view: UIViewController,
        taskEditBuilder: TaskEditBuilder,
        dayBuilder: DayBuilder
    ) {
        self.view = view
        self.taskEditBuilder = taskEditBuilder
        self.dayBuilder = dayBuilder
    }
}

// MARK: - CalendarRouter implementation

extension CalendarRouterImpl: CalendarRouter {
    func showTaskCreation(data: TaskEditData) {
        let editView = taskEditBuilder.build(data: data)
        view?.present(editView, animated: true, completion: nil)
    }

    func showDay(date: Date) {
        let dayView = dayBuilder.build(date: date)
        view?.navigationController?.pushViewController(dayView, animated: true)
    }
}
