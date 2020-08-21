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
    let signInTrigger: Subject<Void, Never>
    
    private let disposeBag = DisposeBag()
    
    init(
        interactor: SignUpInteractor,
        router: SignUpRouter
    ) {
        self.interactor = interactor
        self.router = router
        
        let signInSubject = PassthroughSubject<Void, Never>()
        
        signInSubject
            .observeNext {
                router.showSignIn()
            }
            .dispose(in: disposeBag)
        
        signInTrigger = signInSubject
    }
}
