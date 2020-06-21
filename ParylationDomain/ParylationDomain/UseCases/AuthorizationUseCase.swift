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
    
    public func saveUser(user: User) -> Signal<Void, AuthorizationUseCaseError> {
        return authorizedUserRepository.saveUser(user: user)
            .mapError { _ in
                return .failed
            }
    }
    
    
}
