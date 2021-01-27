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
    func validate(email: String) -> Single<Bool>
    func validate(username: String) -> Single<Bool>
    func fetchUser() -> Single<User>
    func update(email: String) -> Single<Void>
    func update(username: String) -> Single<Void>
    func update(password: String) -> Single<Void>
    func signout() -> Single<Void>
}

public final class SettingsInteractorImpl {
    private let credentialsValidatorService: CredentialsValidatorService
    private let authorizationService: AuthorizationService
    private let userService: UserService

    public init(
        credentialsValidatorService: CredentialsValidatorService,
        authorizationService: AuthorizationService,
        userService: UserService
    ) {
        self.credentialsValidatorService = credentialsValidatorService
        self.authorizationService = authorizationService
        self.userService = userService
    }
}

// MARK: - SettingsInteractor implementation

extension SettingsInteractorImpl: SettingsInteractor {
    public func validate(email: String) -> Single<Bool> {
        return credentialsValidatorService.validate(email: email)
            .catchError { _ in .error(SettingsInteractorError.failed) }
    }

    public func validate(username: String) -> Single<Bool> {
        return credentialsValidatorService.validate(username: username)
            .catchError { _ in .error(SettingsInteractorError.failed) }
    }

    public func fetchUser() -> Single<User> {
        return userService.fetchUser()
            .catchError { _ in .error(SettingsInteractorError.failed) }
    }

    public func update(email: String) -> Single<Void> {
        return userService.update(email: email)
            .catchError { _ in .error(SettingsInteractorError.failed) }
    }

    public func update(username: String) -> Single<Void> {
        return userService.update(username: username)
            .catchError { _ in .error(SettingsInteractorError.failed) }
    }

    public func update(password: String) -> Single<Void> {
        return userService.update(password: password)
            .catchError { _ in .error(SettingsInteractorError.failed) }
    }

    public func signout() -> Single<Void> {
        return authorizationService.signout()
            .catchError { _ in .error(SettingsInteractorError.failed) }
    }
}

