//
//  
//  CalendarBuilder.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 27.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//
//

import UIKit
import ParylationDomain

final class CalendarBuilderImpl {
    typealias Context = CalendarContext
    
    private let context: Context

    init(context: Context) {
        self.context = context
    }
}

// MARK: - CalendarBuilder implementation

extension CalendarBuilderImpl: CalendarBuilder {
    func build() -> UIViewController {
        let view = CalendarView()

        let calendar = Calendar(identifier: .gregorian)
        let interactor = CalendarInteractorImpl(calendar: calendar)
        let taskEditBuilder = TaskEditBuilderImpl(context: context)
        let router = CalendarRouterImpl(
            view: view,
            taskEditBuilder: taskEditBuilder
        )
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        let viewModel = CalendarViewModelImpl(
            interactor: interactor,
            router: router,
            calendar: calendar,
            dateFormatter: dateFormatter
        ) 
        view.viewModel = viewModel
        return view
    }
}
