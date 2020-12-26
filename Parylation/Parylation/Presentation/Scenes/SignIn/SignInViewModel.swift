//
//  SignInViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxCocoa
import RxSwift
import ParylationDomain

final class SignInViewModelImpl: SignInViewModel {
    private let interactor: SignInInteractor
    private let router: SignInRouter
    
    let signInTrigger: AnyObserver<Void>
    let signUpTrigger: AnyObserver<Void>
    
    private let disposeBag = DisposeBag()
    
    init(
        interactor: SignInInteractor,
        router: SignInRouter
    ) {
        self.interactor = interactor
        self.router = router
        
        let signInSubject = PublishSubject<Void>()
        signInSubject
            .flatMap { interactor.authorize(email: "", password: "") }
            .subscribe(onNext: { _ in router.finishSignIn() })
            .disposed(by: disposeBag)
        
        let signUpSubject = PublishSubject<Void>()
        signUpSubject
            .subscribe(onNext: { router.showSignUp() })
            .disposed(by: disposeBag)
        
        signInTrigger = signInSubject.asObserver()
        signUpTrigger = signUpSubject.asObserver()
    }
}
