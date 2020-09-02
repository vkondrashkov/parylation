//
//  
//  SettingsBuilder.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/25/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import ParylationDomain 
import UIKit

final class SettingsBuilderImpl {
    typealias Context = SettingsContainer
    
    private let context: Context

    init(context: Context) {
        self.context = context
    }
}

// MARK: - SettingsBuilder implementation

extension SettingsBuilderImpl: SettingsBuilder {
    func build(navigationController: UINavigationController) -> UIViewController {
        let view = SettingsView()

        let interactor = SettingsInteractorImpl()
        let router = SettingsRouterImpl(
            navigationController: navigationController
        )
        let viewModel = SettingsViewModelImpl(
            interactor: interactor,
            router: router
        ) 
        view.viewModel = viewModel
        return view
    }
}
