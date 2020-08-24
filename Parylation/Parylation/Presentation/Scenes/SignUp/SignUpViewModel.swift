//
//  SignUpViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit
import ParylationDomain

final class SignUpViewModelImpl: SignUpViewModel {
    private let interactor: SignUpInteractor
    private let router: SignUpRouter
    
    /// Input
    let signUpTrigger: Subject<Void, Never>
    let signInTrigger: Subject<Void, Never>
    
    private let disposeBag = DisposeBag()
    
    init(
        interactor: SignUpInteractor,
        router: SignUpRouter
    ) {
        self.interactor = interactor
        self.router = router
        
        let signUpSubject = PassthroughSubject<Void, Never>()
        signUpSubject
            .flatMapConcat {
                interactor.register(email: "", password: "")
            }
            .observeNext { _ in
                router.finishSignUp()
            }
            .dispose(in: disposeBag)
        
        let signInSubject = PassthroughSubject<Void, Never>()
        signInSubject
            .observeNext {
                router.showSignIn()
            }
            .dispose(in: disposeBag)
        
        signUpTrigger = signUpSubject
        signInTrigger = signInSubject
    }
}
