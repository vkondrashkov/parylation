//
//  SignUpInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 6/20/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit

public enum SignUpInteractorError: Error {
    case failed
}

public protocol SignUpInteractor {
    func register(email: String, password: String) -> Signal<User, SignUpInteractorError>
}

public final class SignUpInteractorImpl {
    private let authorizationUseCase: AuthorizationUseCase
    
    public init(authorizationUseCase: AuthorizationUseCase) {
        self.authorizationUseCase = authorizationUseCase
    }
}

// MARK: - SignUpInteractor implementation

extension SignUpInteractorImpl: SignUpInteractor {
    public func register(email: String, password: String) -> Signal<User, SignUpInteractorError> {
        return authorizationUseCase.register(email: email, password: password)
            .mapError { _ in return .failed }
    }
}
