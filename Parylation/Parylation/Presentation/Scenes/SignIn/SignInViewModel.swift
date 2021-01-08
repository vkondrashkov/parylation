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

    let email: AnyObserver<String>
    let password: AnyObserver<String>
    let signInTrigger: AnyObserver<Void>
    let signUpTrigger: AnyObserver<Void>

    let emailError: Driver<String?>
    
    private let disposeBag = DisposeBag()
    
    init(
        interactor: SignInInteractor,
        router: SignInRouter
    ) {
        self.interactor = interactor
        self.router = router

        let emailSubject = PublishSubject<String>()
        let emailValidation = emailSubject
            .distinctUntilChanged()
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .flatMap { interactor.validate(email: $0) }

        let passwordSubject = PublishSubject<String>()

        let emailErrorSubject = PublishSubject<String?>()
        emailValidation
            .filter { $0 }
            .map { _ in nil }
            .bind(to: emailErrorSubject)
            .disposed(by: disposeBag)

        let signInData = Observable
            .combineLatest(emailSubject, passwordSubject)

        let signInSubject = PublishSubject<Void>()
        signInSubject
            .withLatestFrom(emailValidation)
            .do(onNext: { isEmailValid in
                let emailError = isEmailValid ? nil : L10n.signUpInvalidEmail
                emailErrorSubject.onNext(emailError)
            })
            .filter { $0 }
            .withLatestFrom(signInData)
            .flatMap { interactor.authorize(email: $0, password: $1) }
            .subscribe(onNext: { _ in router.finishSignIn() })
            .disposed(by: disposeBag)
        
        let signUpSubject = PublishSubject<Void>()
        signUpSubject
            .subscribe(onNext: { router.showSignUp() })
            .disposed(by: disposeBag)

        email = emailSubject.asObserver()
        password = passwordSubject.asObserver()
        signInTrigger = signInSubject.asObserver()
        signUpTrigger = signUpSubject.asObserver()

        emailError = emailErrorSubject
            .asDriver(onErrorJustReturn: nil)
    }
}
