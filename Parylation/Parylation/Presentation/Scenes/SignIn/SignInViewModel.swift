//
//  SignInViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit
import ParylationDomain

final class SignInViewModelImpl: SignInViewModel {
    private let interactor: SignInInteractor
    private let router: SignInRouter
    
    /// Input
    let signInTrigger: Subject<Void, Never>
    let signUpTrigger: Subject<Void, Never>
    
    private let disposeBag = DisposeBag()
    
    init(
        interactor: SignInInteractor,
        router: SignInRouter
    ) {
        self.interactor = interactor
        self.router = router
        
        let signInSubject = PassthroughSubject<Void, Never>()
        signInSubject
            .flatMapConcat {
                interactor.authorize(email: "", password: "")
            }
            .observeNext { _ in
                router.finishSignIn()
            }
            .dispose(in: disposeBag)
        
        let signUpSubject = PassthroughSubject<Void, Never>()
        signUpSubject
            .observeNext {
                router.showSignUp()
            }
            .dispose(in: disposeBag)
        
        signInTrigger = signInSubject
        signUpTrigger = signUpSubject
    }
}
