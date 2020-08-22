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
    let signUpTrigger: Subject<Void, Never>
    
    private let disposeBag = DisposeBag()
    
    init(
        interactor: SignInInteractor,
        router: SignInRouter
    ) {
        self.interactor = interactor
        self.router = router
        
        let signUpSubject = PassthroughSubject<Void, Never>()
        signUpSubject
            .observeNext {
                router.showSignUp()
            }
            .dispose(in: disposeBag)
        
        signUpTrigger = signUpSubject
    }
}
