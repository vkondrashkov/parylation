//
//  SignUpViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxCocoa
import RxSwift
import ParylationDomain

final class SignUpViewModelImpl: SignUpViewModel {
    private let interactor: SignUpInteractor
    private let router: SignUpRouter
    
    let signUpTrigger: AnyObserver<Void>
    let signInTrigger: AnyObserver<Void>
    
    private let disposeBag = DisposeBag()
    
    init(
        interactor: SignUpInteractor,
        router: SignUpRouter
    ) {
        self.interactor = interactor
        self.router = router
        
        let signUpSubject = PublishSubject<Void>()
        signUpSubject
            .flatMap { interactor.register(email: "", password: "") }
            .subscribe(onNext: { _ in router.finishSignUp() })
            .disposed(by: disposeBag)
        
        let signInSubject = PublishSubject<Void>()
        signInSubject
            .subscribe(onNext: { router.showSignIn() })
            .disposed(by: disposeBag)
        
        signUpTrigger = signUpSubject.asObserver()
        signInTrigger = signInSubject.asObserver()
    }
}
