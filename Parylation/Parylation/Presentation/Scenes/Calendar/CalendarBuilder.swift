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
    typealias Context = CalendarContainer
    
    private let context: Context

    init(context: Context) {
        self.context = context
    }
}

// MARK: - CalendarBuilder implementation

extension CalendarBuilderImpl: CalendarBuilder {
    func build() -> UIViewController {
        let view = CalendarView()

        let interactor = CalendarInteractorImpl()
        let router = CalendarRouterImpl(
            view: view
        )
        let viewModel = CalendarViewModelImpl(
            interactor: interactor,
            router: router
        ) 
        view.viewModel = viewModel
        return view
    }
}
