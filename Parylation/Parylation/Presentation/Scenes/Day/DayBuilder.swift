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
    typealias Context = DayContainer
    
    private let context: Context

    init(context: Context) {
        self.context = context
    }
}

// MARK: - DayBuilder implementation

extension DayBuilderImpl: DayBuilder {
    func build() -> UIViewController {
        let view = DayView()

        let interactor = DayInteractorImpl()
        let router = DayRouterImpl(
            view: view
        )
        let viewModel = DayViewModelImpl(
            interactor: interactor,
            router: router
        ) 
        view.viewModel = viewModel
        return view
    }
}
