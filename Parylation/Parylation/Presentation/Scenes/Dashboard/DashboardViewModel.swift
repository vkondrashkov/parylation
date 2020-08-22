//
//  DashboardViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit
import ParylationDomain

final class DashboardViewModelImpl: DashboardViewModel {
    private let interactor: DashboardInteractor
    private let router: DashboardRouter
    
    /// Input
    let viewWillAppearTrigger: Subject<Void, Never>
    
    private let disposeBag = DisposeBag()
    
    init(
        interactor: DashboardInteractor,
        router: DashboardRouter
    ) {
        self.interactor = interactor
        self.router = router
        
        let viewWillAppearSubject = PassthroughSubject<Void, Never>()
        viewWillAppearSubject
            .observeNext {
                router.showTabs()
            }
            .dispose(in: disposeBag)
        
        viewWillAppearTrigger = viewWillAppearSubject
    }
}
