//
//  AuthorizationService.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 6/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum AuthorizationServiceError: Error {
    case failed
    case missingData
}

public protocol AuthorizationService: AnyObject {
    func isAuthorized() -> Single<Bool>
    func authorize(email: String, password: String) -> Single<User>
    func register(email: String, password: String) -> Single<User>
    func signout() -> Single<Void>
}

public final class AuthorizationServiceImpl: AuthorizationService {
    private let userRepository: UserRepository
    private let authorizedUserRepository: AuthorizedUserRepository
    
    public init(
        userRepository: UserRepository,
        authorizedUserRepository: AuthorizedUserRepository
    ) {
        self.userRepository = userRepository
        self.authorizedUserRepository = authorizedUserRepository
    }
    
    public func isAuthorized() -> Single<Bool> {
        return authorizedUserRepository.fetchUser()
            .map { _ in true }
            .catchError { _ in .just(false) }
    }
    
    public func authorize(email: String, password: String) -> Single<User> {
        let user = userRepository.authorizeUser(login: email, password: password)
        return user
            .flatMap { self.authorizedUserRepository.saveUser(user: $0) }
            .asObservable()
            .withLatestFrom(user)
            .asSingle()
            .catchError { _ in .error(AuthorizationServiceError.failed) }
    }
    
    public func register(email: String, password: String) -> Single<User> {
        let user = userRepository.registerUser(login: email, password: password)
        return user
            .flatMap { self.authorizedUserRepository.saveUser(user: $0) }
            .asObservable()
            .withLatestFrom(user)
            .asSingle()
            .catchError { _ in .error(AuthorizationServiceError.failed) }
    }

    public func signout() -> Single<Void> {
        return userRepository.signout()
            .flatMap { self.authorizedUserRepository.deleteUser() }
            .catchError { _ in .error(AuthorizationServiceError.failed) }
    }
}
