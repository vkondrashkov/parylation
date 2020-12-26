//
//  RootInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 6/20/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum RootInteractorError: Error {
    case failed
}

public protocol RootInteractor {
    func isUserAuthorized() -> Single<Bool>
}

public final class RootInteractorImpl {
    private let authorizationUseCase: AuthorizationUseCase
    
    public init(authorizationUseCase: AuthorizationUseCase) {
        self.authorizationUseCase = authorizationUseCase
    }
}

// MARK: - RootInteractor implementation

extension RootInteractorImpl: RootInteractor {
    public func isUserAuthorized() -> Single<Bool> {
        return authorizationUseCase.isAuthorized()
            .catchError { _ in .error(RootInteractorError.failed) }
    }
}
