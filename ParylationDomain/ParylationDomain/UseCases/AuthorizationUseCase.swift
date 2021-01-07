//
//  AuthorizationUseCase.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 6/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum AuthorizationUseCaseError: Error {
    case failed
    case missingData
}

public protocol AuthorizationUseCase: AnyObject {
    func isAuthorized() -> Single<Bool>
    func fetchCurrentUser() -> Single<User>
    func authorize(email: String, password: String) -> Single<User>
    func register(email: String, password: String) -> Single<User>
    // DEPRECATED
    @available(*, deprecated, message: "Do not use this method")
    func saveUser(user: User) -> Single<Void>
}

public final class AuthorizationUseCaseImpl: AuthorizationUseCase {
    private let authorizedUserRepository: AuthorizedUserRepository
    
    public init(authorizedUserRepository: AuthorizedUserRepository) {
        self.authorizedUserRepository = authorizedUserRepository
    }
    
    public func isAuthorized() -> Single<Bool> {
        return authorizedUserRepository.fetchUser()
            .map { _ in true }
            .catchError { _ in .just(false) }
    }
    
    public func fetchCurrentUser() -> Single<User> {
        return authorizedUserRepository.fetchUser()
            .catchError { _ in .error(AuthorizationUseCaseError.missingData) }
    }
    
    public func authorize(email: String, password: String) -> Single<User> {
        // TODO: DO API LOGIC
        let user = User(id: "123", name: "Vladislav")
        return authorizedUserRepository.saveUser(user: user)
            .map { _ in user }
            .catchError { _ in .error(AuthorizationUseCaseError.failed) }
    }
    
    public func register(email: String, password: String) -> Single<User> {
        // TODO: DO API LOGIC
        let user = User(id: "123", name: "Vladislav")
        return authorizedUserRepository.saveUser(user: user)
            .map { _ in user }
            .catchError { _ in .error(AuthorizationUseCaseError.failed) }
    }
    
    public func saveUser(user: User) -> Single<Void> {
        return authorizedUserRepository.saveUser(user: user)
            .catchError { _ in .error(AuthorizationUseCaseError.failed) }
    }
    
    
}
