//
//  UserService.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 21.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum UserServiceError: Error {
    case failed
    case missingData
}

public protocol UserService: AnyObject {
    func fetchUser() -> Single<User>
    func update(email: String) -> Single<Void>
    func update(username: String) -> Single<Void>
    func update(password: String) -> Single<Void>
}

public final class UserServiceImpl: UserService {
    private let userRepository: UserRepository
    private let authorizedUserRepository: AuthorizedUserRepository

    public init(
        userRepository: UserRepository,
        authorizedUserRepository: AuthorizedUserRepository
    ) {
        self.userRepository = userRepository
        self.authorizedUserRepository = authorizedUserRepository
    }

    public func fetchUser() -> Single<User> {
        return authorizedUserRepository.fetchUser()
            .catchError { _ in .error(UserServiceError.missingData)}
    }

    public func update(email: String) -> Single<Void> {
        return authorizedUserRepository.fetchUser()
            .map { $0.id }
            .flatMap { self.userRepository.update(userId: $0, email: email) }
            .flatMap { self.authorizedUserRepository.saveUser(user: $0) }
            .catchError { _ in .error(UserServiceError.failed) }
    }

    public func update(username: String) -> Single<Void> {
        return authorizedUserRepository.fetchUser()
            .map { $0.id }
            .flatMap { self.userRepository.update(userId: $0, username: username) }
            .flatMap { self.authorizedUserRepository.saveUser(user: $0) }
            .catchError { _ in .error(UserServiceError.failed) }
    }

    public func update(password: String) -> Single<Void> {
        return authorizedUserRepository.fetchUser()
            .map { $0.id }
            .flatMap { self.userRepository.update(userId: $0, password: password) }
            .catchError { _ in .error(UserServiceError.failed) }
    }
}
