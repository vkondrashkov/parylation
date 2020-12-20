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
}

public final class SignInInteractorImpl {
    private let authorizationUseCase: AuthorizationUseCase
    
    public init(authorizationUseCase: AuthorizationUseCase) {
        self.authorizationUseCase = authorizationUseCase
    }
}

// MARK: - SignInInteractor implementation

extension SignInInteractorImpl: SignInInteractor {
    public func authorize(email: String, password: String) -> Single<User> {
        return authorizationUseCase.authorize(email: email, password: password)
            .catchError { _ in .error(SignInInteractorError.failed) }
    }
}
