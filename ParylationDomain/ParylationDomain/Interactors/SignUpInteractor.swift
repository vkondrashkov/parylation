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
    func validate(email: String) -> Single<Bool>
    func validate(password: String) -> Single<Bool>
    func validate(password: String, confirmPassword: String) -> Single<Bool>
}

public final class SignUpInteractorImpl {
    private let authorizationService: AuthorizationService
    private let credentialsValidatorService: CredentialsValidatorService
    
    public init(
        authorizationService: AuthorizationService,
        credentialsValidatorService: CredentialsValidatorService
    ) {
        self.authorizationService = authorizationService
        self.credentialsValidatorService = credentialsValidatorService
    }
}

// MARK: - SignUpInteractor implementation

extension SignUpInteractorImpl: SignUpInteractor {
    public func register(email: String, password: String) -> Single<User> {
        return authorizationService.register(email: email, password: password)
            .catchError { _ in .error(SignInInteractorError.failed) }
    }

    public func validate(email: String) -> Single<Bool> {
        return credentialsValidatorService.validate(email: email)
    }

    public func validate(password: String) -> Single<Bool> {
        return credentialsValidatorService.validate(password: password)
    }

    public func validate(password: String, confirmPassword: String) -> Single<Bool> {
        return .just(password == confirmPassword && !password.isEmpty && !confirmPassword.isEmpty)
    }
}
