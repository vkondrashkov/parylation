//
//  
//  TaskEditBuilder.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import ParylationDomain
import UIKit

final class TaskEditBuilderImpl {
    typealias Context = TaskEditContainer
    
    private let context: Context

    init(context: Context) {
        self.context = context
    }
}

// MARK: - TaskEditBuilder implementation

extension TaskEditBuilderImpl: TaskEditBuilder {
    func build(taskId: String?) -> UIViewController {
        let view = TaskEditView()

        let interactor = TaskEditInteractorImpl(
            taskRepository: context.taskRepository,
            credentialsValidatorService: CredentialsValidatorServiceImpl(),
            pushNotificationsUseCase: context.pushNotificationsUseCase
        )
        let router = TaskEditRouterImpl(
            viewController: view
        )
        let viewModel = TaskEditViewModelImpl(
            interactor: interactor,
            router: router,
            taskId: taskId
        ) 
        view.viewModel = viewModel
        return view
    }
}
