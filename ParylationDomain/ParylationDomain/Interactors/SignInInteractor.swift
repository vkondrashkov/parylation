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

// MARK: - SignInInteractor implementation

extension SignInInteractorImpl: SignInInteractor {
    public func authorize(email: String, password: String) -> Single<User> {
        return authorizationService.authorize(email: email, password: password)
            .catchError { _ in .error(SignInInteractorError.failed) }
    }

    public func validate(email: String) -> Single<Bool> {
        return credentialsValidatorService.validate(email: email)
            .catchError { _ in .error(SignInInteractorError.failed) }
    }
}
