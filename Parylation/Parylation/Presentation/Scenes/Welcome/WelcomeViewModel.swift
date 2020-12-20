//
//  WelcomeViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxCocoa
import RxSwift
import ParylationDomain

final class WelcomeViewModelImpl: WelcomeViewModel {
    private let interactor: WelcomeInteractor
    private let router: WelcomeRouter
    
    let signUpTrigger: AnyObserver<Void>
    let signInTrigger: AnyObserver<Void>
    
    private let disposeBag = DisposeBag()
    
    init(
        interactor: WelcomeInteractor,
        router: WelcomeRouter
    ) {
        self.interactor = interactor
        self.router = router
        
        let signUpSubject = PublishSubject<Void>()
        signUpSubject
            .subscribe(onNext: { router.showSignUp() })
            .disposed(by: disposeBag)
        
        let signInSubject = PublishSubject<Void>()
        signInSubject
            .subscribe(onNext: { router.showSignIn() })
            .disposed(by: disposeBag)
        
        signUpTrigger = signUpSubject.asObserver()
        signInTrigger = signInSubject.asObserver()
    }
}
