//
//  SignInInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit

public enum SignInInteractorError: Error {
    case failed
}

public protocol SignInInteractor {
    func authorize(email: String, password: String) -> Signal<User, SignInInteractorError>
}

public final class SignInInteractorImpl {
    private let authorizationUseCase: AuthorizationUseCase
    
    public init(authorizationUseCase: AuthorizationUseCase) {
        self.authorizationUseCase = authorizationUseCase
    }
}

// MARK: - SignInInteractor implementation

extension SignInInteractorImpl: SignInInteractor {
    public func authorize(email: String, password: String) -> Signal<User, SignInInteractorError> {
        return authorizationUseCase.authorize(email: email, password: password)
            .mapError { _ in return .failed }
    }
}
