//
//  AuthorizationUseCase.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 6/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import ReactiveKit

public enum AuthorizationUseCaseError: Error {
    case failed
    case missingData
}

public protocol AuthorizationUseCase: AnyObject {
    func isAuthorized() -> Signal<Bool, AuthorizationUseCaseError>
    func fetchCurrentUser() -> Signal<User, AuthorizationUseCaseError>
    func authorize(email: String, password: String) -> Signal<User, AuthorizationUseCaseError>
    func register(email: String, password: String) -> Signal<User, AuthorizationUseCaseError>
    // DEPRECATED
    func saveUser(user: User) -> Signal<Void, AuthorizationUseCaseError>
}

public final class AuthorizationUseCaseImpl: AuthorizationUseCase {
    private let authorizedUserRepository: AuthorizedUserRepository
    
    public init(authorizedUserRepository: AuthorizedUserRepository) {
        self.authorizedUserRepository = authorizedUserRepository
    }
    
    public func isAuthorized() -> Signal<Bool, AuthorizationUseCaseError> {
        return authorizedUserRepository.fetchUser()
            .flatMapConcat { _ in
                return Signal(just: true)
            }
            .flatMapError { error -> Signal<Bool, AuthorizationUseCaseError>  in
                if case .failed = error {
                    return .failed(.failed)
                }
                return Signal(just: false)
            }
    }
    
    public func fetchCurrentUser() -> Signal<User, AuthorizationUseCaseError> {
        return authorizedUserRepository.fetchUser()
            .mapError { error in
                switch error {
                case .failed:
                    return .failed
                case .missingData:
                    return .missingData
                }
            }
    }
    
    public func authorize(email: String, password: String) -> Signal<User, AuthorizationUseCaseError> {
        // DO API LOGIC
        let user = User(id: "123", name: "Vladislav")
        return authorizedUserRepository.saveUser(user: user)
            .map { _ in return user }
            .mapError { _ in return .failed }
    }
    
    public func register(email: String, password: String) -> Signal<User, AuthorizationUseCaseError> {
        // DO API LOGIC
        let user = User(id: "123", name: "Vladislav")
        return authorizedUserRepository.saveUser(user: user)
            .map { _ in return user }
            .mapError { _ in return .failed }
    }
    
    public func saveUser(user: User) -> Signal<Void, AuthorizationUseCaseError> {
        return authorizedUserRepository.saveUser(user: user)
            .mapError { _ in
                return .failed
            }
    }
    
    
}
