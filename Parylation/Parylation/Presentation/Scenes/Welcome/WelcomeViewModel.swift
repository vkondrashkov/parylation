//
//  WelcomeViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit
import ParylationDomain

final class WelcomeViewModelImpl: WelcomeViewModel {
    private let interactor: WelcomeInteractor
    private let router: WelcomeRouter
    
    /// Input
    let signUpTrigger: Subject<Void, Never>
    let signInTrigger: Subject<Void, Never>
    
    private let disposeBag = DisposeBag()
    
    init(
        interactor: WelcomeInteractor,
        router: WelcomeRouter
    ) {
        self.interactor = interactor
        self.router = router
        
        let signUpSubject = PassthroughSubject<Void, Never>()
        signUpSubject
            .observeNext {
                router.showSignUp()
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
