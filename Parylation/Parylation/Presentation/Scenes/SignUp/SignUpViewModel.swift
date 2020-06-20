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
    
    init(
        interactor: SignUpInteractor,
        router: SignUpRouter
    ) {
        self.interactor = interactor
        self.router = router
    }
}
