//
//  HomeBuilder.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit
import ParylationDomain

final class HomeBuilderImpl {
    typealias Context = HomeContainer & TaskContainer
    
    private let context: Context
    
    init(context: Context) {
        self.context = context
    }
}

// MARK: - HomeBuilder implementation

extension HomeBuilderImpl: HomeBuilder {
    func build() -> UIViewController {
        let view = HomeView()
        let interactor = HomeInteractorImpl(
            taskRepository: context.taskRepository
        )
        let taskBuilder = TaskBuilderImpl(context: context)
        let router = HomeRouterImpl(
            view: view,
            taskBuilder: taskBuilder
        )
        let viewModel = HomeViewModelImpl(
            interactor: interactor,
            router: router
        )
        view.viewModel = viewModel
        return view
    }
}
