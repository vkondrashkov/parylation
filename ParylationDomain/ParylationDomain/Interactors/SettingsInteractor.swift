//
//  
//  SettingsInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 8/25/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import RxSwift

public enum SettingsInteractorError: Error {
    case failed
}

public protocol SettingsInteractor {
    func signout() -> Single<Void>
}

public final class SettingsInteractorImpl {
    private let authorizationUseCase: AuthorizationUseCase

    public init(authorizationUseCase: AuthorizationUseCase) {
        self.authorizationUseCase = authorizationUseCase
    }
}

// MARK: - SettingsInteractor implementation

extension SettingsInteractorImpl: SettingsInteractor {
    public func signout() -> Single<Void> {
        return authorizationUseCase.signout()
            .catchError { _ in .error(SettingsInteractorError.failed) }
    }
}

