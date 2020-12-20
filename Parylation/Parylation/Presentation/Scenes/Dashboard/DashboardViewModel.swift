//
//  DashboardViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxCocoa
import RxSwift
import ParylationDomain

final class DashboardViewModelImpl: DashboardViewModel {
    private let interactor: DashboardInteractor
    private let router: DashboardRouter

    let viewWillAppearTrigger: AnyObserver<Void>
    
    private let disposeBag = DisposeBag()
    
    init(
        interactor: DashboardInteractor,
        router: DashboardRouter
    ) {
        self.interactor = interactor
        self.router = router
        
        let viewWillAppearSubject = PublishSubject<Void>()
        viewWillAppearSubject
            .subscribe(onNext: { router.showTabs() })
            .disposed(by: disposeBag)
        
        viewWillAppearTrigger = viewWillAppearSubject.asObserver()
    }
}
