//
//  
//  DayBuilder.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 10.02.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//
//

import UIKit
import ParylationDomain

final class DayBuilderImpl {
    typealias Context = DayContainer & TaskContainer & TaskEditContainer
    
    private let context: Context

    init(context: Context) {
        self.context = context
    }
}

// MARK: - DayBuilder implementation

extension DayBuilderImpl: DayBuilder {
    func build(date: Date) -> UIViewController {
        let view = DayView()

        let interactor = DayInteractorImpl(
            taskRepository: context.taskRepository,
            iconRepository: context.iconRepository,
            colorRepository: context.colorRepository
        )
        let taskBuilder = TaskBuilderImpl(context: context)
        let taskEditBuilder = TaskEditBuilderImpl(context: context)
        let router = DayRouterImpl(
            view: view,
            taskBuilder: taskBuilder,
            taskEditBuilder: taskEditBuilder
        )
        let viewModel = DayViewModelImpl(
            interactor: interactor,
            router: router,
            date: date
        ) 
        view.viewModel = viewModel
        return view
    }
}
