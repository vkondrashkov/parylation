//
// 
//  DayViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 10.02.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//
//

import RxCocoa
import RxSwift
import ParylationDomain

final class DayViewModelImpl: DayViewModel {
    private let interactor: DayInteractor
    private let router: DayRouter

    init(
        interactor: DayInteractor,
        router: DayRouter
    ) {
        self.interactor = interactor
        self.router = router
    }
}
