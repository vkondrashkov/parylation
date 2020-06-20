//
//  DashboardViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit

final class DashboardViewModelImpl: DashboardViewModel {
    private let interactor: DashboardInteractor
    private let router: DashboardRouter
    
    init(
        interactor: DashboardInteractor,
        router: DashboardRouter
    ) {
        self.interactor = interactor
        self.router = router
    }
}
