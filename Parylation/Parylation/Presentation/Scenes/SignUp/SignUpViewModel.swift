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

    let email: AnyObserver<String>
    let password: AnyObserver<String>
    let confirmPassword: AnyObserver<String>
    let didEndEditingTrigger: AnyObserver<SignUpField>
    let signUpTrigger: AnyObserver<Void>
    let signInTrigger: AnyObserver<Void>

    let emailError: Driver<String?>
    let passwordError: Driver<String?>
    let confirmPasswordError: Driver<String?>
    
    private let disposeBag = DisposeBag()
    
    init(
        interactor: SignUpInteractor,
        router: SignUpRouter
    ) {
        self.interactor = interactor
        self.router = router

        let didEndEditingSubject = PublishSubject<SignUpField>()

        let emailSubject = PublishSubject<String>()
        let emailValidation = emailSubject
            .distinctUntilChanged()
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .flatMap { interactor.validate(email: $0) }

        let passwordSubject = PublishSubject<String>()
        let passwordValidation = passwordSubject
            .distinctUntilChanged()
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .flatMap { interactor.validate(password: $0) }

        let confirmPasswordSubject = PublishSubject<String>()
        let confirmPasswordValidation = confirmPasswordSubject
            .distinctUntilChanged()
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(passwordSubject) { (password: $1, confirmPassword: $0) }
            .flatMap { interactor.validate(password: $0, confirmPassword: $1) }

        let emailErrorSubject = PublishSubject<String?>()
        emailValidation
            .filter { $0 }
            .map { _ in nil }
            .bind(to: emailErrorSubject)
            .disposed(by: disposeBag)
        let passwordErrorSubject = PublishSubject<String?>()
        passwordValidation
            .filter { $0 }
            .map { _ in nil }
            .bind(to: passwordErrorSubject)
            .disposed(by: disposeBag)
        let confirmPasswordErrorSubject = PublishSubject<String?>()
        confirmPasswordValidation
            .filter { $0 }
            .map { _ in nil }
            .bind(to: confirmPasswordErrorSubject)
            .disposed(by: disposeBag)

        let validation = Observable.combineLatest(emailValidation, passwordValidation, confirmPasswordValidation)

        let signUpSubject = PublishSubject<Void>()
        signUpSubject
            .withLatestFrom(validation)
            .do(onNext: { isEmailValid, isPasswordValid, isConfirmPasswordValid in
                let emailError = isEmailValid ? nil : L10n.signUpInvalidEmail
                emailErrorSubject.onNext(emailError)
                let passwordError = isPasswordValid ? nil : L10n.signUpInvalidPassword
                passwordErrorSubject.onNext(passwordError)
                let confirmPasswordError = isConfirmPasswordValid ? nil : L10n.signUpInvalidConfirmPassword
                confirmPasswordErrorSubject.onNext(confirmPasswordError)
            })
            .map { $0 && $1 && $2 }
            .filter { $0 }
            .map { _ in () }
            .flatMap { interactor.register(email: "", password: "") }
            .subscribe(onNext: { _ in router.finishSignUp() })
            .disposed(by: disposeBag)
        
        let signInSubject = PublishSubject<Void>()
        signInSubject
            .subscribe(onNext: { router.showSignIn() })
            .disposed(by: disposeBag)

        email = emailSubject.asObserver()
        password = passwordSubject.asObserver()
        confirmPassword = confirmPasswordSubject.asObserver()
        didEndEditingTrigger = didEndEditingSubject.asObserver()
        signUpTrigger = signUpSubject.asObserver()
        signInTrigger = signInSubject.asObserver()

        emailError = emailErrorSubject
            .asDriver(onErrorJustReturn: nil)
        passwordError = passwordErrorSubject
            .asDriver(onErrorJustReturn: nil)
        confirmPasswordError = confirmPasswordErrorSubject
            .asDriver(onErrorJustReturn: nil)
    }
}
