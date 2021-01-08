//
//  SignInInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum SignInInteractorError: Error {
    case failed
}

public protocol SignInInteractor {
    func authorize(email: String, password: String) -> Single<User>
    func validate(email: String) -> Single<Bool>
}

public final class SignInInteractorImpl {
    private let authorizationUseCase: AuthorizationUseCase
    private let credentialsValidatorUseCase: CredentialsValidatorUseCase
    
    public init(
        authorizationUseCase: AuthorizationUseCase,
        credentialsValidatorUseCase: CredentialsValidatorUseCase
    ) {
        self.authorizationUseCase = authorizationUseCase
        self.credentialsValidatorUseCase = credentialsValidatorUseCase
    }
}

// MARK: - SignInInteractor implementation

extension SignInInteractorImpl: SignInInteractor {
    public func authorize(email: String, password: String) -> Single<User> {
        return authorizationUseCase.authorize(email: email, password: password)
            .catchError { _ in .error(SignInInteractorError.failed) }
    }

    public func validate(email: String) -> Single<Bool> {
        return credentialsValidatorUseCase.validate(email: email)
            .catchError { _ in .error(SignInInteractorError.failed) }
    }
}
