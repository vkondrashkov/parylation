//
// 
//  SettingsViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/25/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import Bond
import ReactiveKit
import ParylationDomain

final class SettingsViewModelImpl: SettingsViewModel {
    private let interactor: SettingsInteractor
    private let router: SettingsRouter

    init(
        interactor: SettingsInteractor,
        router: SettingsRouter
    ) {
        self.interactor = interactor
        self.router = router
    }
}
