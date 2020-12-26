//
//  SignUpInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 6/20/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum SignUpInteractorError: Error {
    case failed
}

public protocol SignUpInteractor {
    func register(email: String, password: String) -> Single<User>
}

public final class SignUpInteractorImpl {
    private let authorizationUseCase: AuthorizationUseCase
    
    public init(authorizationUseCase: AuthorizationUseCase) {
        self.authorizationUseCase = authorizationUseCase
    }
}

// MARK: - SignUpInteractor implementation

extension SignUpInteractorImpl: SignUpInteractor {
    public func register(email: String, password: String) -> Single<User> {
        return authorizationUseCase.register(email: email, password: password)
            .catchError { _ in .error(SignInInteractorError.failed) }
    }
}
