//
//  RootViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxCocoa
import RxSwift
import ParylationDomain

final class RootViewModelImpl: RootViewModel {
    private let interactor: RootInteractor
    private let router: RootRouter

    let viewDidAppearTrigger: AnyObserver<Void>
    
    private let disposeBag = DisposeBag()
    
    init(
        interactor: RootInteractor,
        router: RootRouter
    ) {
        self.interactor = interactor
        self.router = router

        let viewDidAppearSubject = PublishSubject<Void>()
        let sharedDidAppear = viewDidAppearSubject
            .share()

        sharedDidAppear
            .flatMap { interactor.requestPushNotificationPermissions() }
            .subscribe(onNext: { _ in })
            .disposed(by: disposeBag)
        
        let isUserAuthorized = sharedDidAppear
            .flatMap { interactor.isUserAuthorized() }
            .catchErrorJustReturn(false)
        
        isUserAuthorized
            .subscribe(onNext: { _isUserAuthorized in
                if _isUserAuthorized {
                    router.showDashboard()
                } else {
                    router.showWelcome()
                }
            })
            .disposed(by: disposeBag)

        viewDidAppearTrigger = viewDidAppearSubject.asObserver()
    }
}
