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
    func build(data: TaskEditData?) -> UIViewController {
        let view = TaskEditView()

        let interactor = TaskEditInteractorImpl(
            taskRepository: context.taskRepository,
            iconRepository: IconRepositoryImpl(),
            colorRepository: ColorRepositoryImpl(),
            credentialsValidatorService: CredentialsValidatorServiceImpl(),
            pushNotificationsService: context.pushNotificationsService
        )
        let router = TaskEditRouterImpl(
            viewController: view
        )
        let viewModel = TaskEditViewModelImpl(
            interactor: interactor,
            router: router,
            data: data
        ) 
        view.viewModel = viewModel
        return view
    }
}
