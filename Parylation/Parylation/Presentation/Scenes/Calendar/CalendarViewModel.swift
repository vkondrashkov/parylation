//
// 
//  CalendarViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 27.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//
//

import RxCocoa
import RxSwift
import ParylationDomain

final class CalendarViewModelImpl: CalendarViewModel {
    private let interactor: CalendarInteractor
    private let router: CalendarRouter

    init(
        interactor: CalendarInteractor,
        router: CalendarRouter
    ) {
        self.interactor = interactor
        self.router = router
    }
}
