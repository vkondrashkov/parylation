//
//  RootViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit

final class RootViewModelImpl: RootViewModel {
    private let interactor: RootInteractor
    private let router: RootRouter
    
    let viewDidLoadTrigger = PassthroughSubject<Void, Never>()
    
    private let disposeBag = DisposeBag()
    
    init(
        interactor: RootInteractor,
        router: RootRouter
    ) {
        self.interactor = interactor
        self.router = router
        
        let isUserAuthorized = viewDidLoadTrigger
            .flatMapConcat {
                interactor.isUserAuthorized()
            }
        
        isUserAuthorized
            .observeNext { isUserAuthorized_ in
                if isUserAuthorized_ {
                    router.showDashboard()
                } else {
                    router.showAuth()
                }
            }
            .dispose(in: disposeBag)
    }
}
