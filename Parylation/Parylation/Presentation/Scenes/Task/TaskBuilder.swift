//
//  
//  TaskBuilder.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import ParylationDomain
import UIKit

final class TaskBuilderImpl {
    typealias Context = TaskContainer & TaskEditContainer
    
    private let context: Context

    init(context: Context) {
        self.context = context
    }
}

// MARK: - TaskBuilder implementation

extension TaskBuilderImpl: TaskBuilder {
    func build(taskId: String) -> UIViewController {
        let view = TaskView()

        let interactor = TaskInteractorImpl(
            taskRepository: context.taskRepository
        )
        let alertBuilder = AlertBuilderImpl()
        let taskEditBuilder = TaskEditBuilderImpl(context: context)
        let router = TaskRouterImpl(
            viewController: view,
            alertBuilder: alertBuilder,
            taskEditBuilder: taskEditBuilder
        )
        let viewModel = TaskViewModelImpl(
            interactor: interactor,
            router: router,
            taskId: taskId
        ) 
        view.viewModel = viewModel
        return view
    }
}
