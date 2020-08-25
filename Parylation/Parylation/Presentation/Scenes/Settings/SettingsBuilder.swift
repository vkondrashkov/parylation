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
    private let dependency: SettingsDependency

    init(dependency: SettingsDependency) {
        self.dependency = dependency
    }
}

// MARK: - SettingsBuilder implementation

extension SettingsBuilderImpl: SettingsBuilder {
    func build() -> UIViewController {
        let view = SettingsView()
        let component = SettingsComponent()

        let navigationScene = NavigationScene(navigationController: dependency.navigationController)
        let interactor = SettingsInteractorImpl()
        let router = SettingsRouterImpl(
            navigationScene: navigationScene
        )
        let viewModel = SettingsViewModelImpl(
            interactor: interactor,
            router: router
        ) 
        view.viewModel = viewModel
        return view
    }
}
