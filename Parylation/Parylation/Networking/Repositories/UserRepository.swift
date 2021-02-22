//
//  UserRepository.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift
import Moya
import ParylationDomain

final class UserRepositoryImpl: UserRepository {
    private let provider: MoyaProvider<UserAPI>
    
    init(provider: MoyaProvider<UserAPI>) {
        self.provider = provider
    }
    
    func registerUser(login: String, password: String) -> Single<User> {
        return provider.rx
            .request(.signUp(login: login, password: password))
            .map(MappableUser.self)
            .map { $0.toDomain() }
            .catchError { _ in .error(UserRepositoryError.failed) }
    }
    
    func authorizeUser(login: String, password: String) -> Single<User> {
        return provider.rx
            .request(.signIn(login: login, password: password))
            .map(MappableUser.self)
            .map { $0.toDomain() }
            .catchError { _ in .error(UserRepositoryError.failed) }
    }

    func update(userId: String, email: String) -> Single<User> {
        return provider.rx
            .request(.updateEmail(userId: userId, email: email))
            .map(MappableUser.self)
            .map { $0.toDomain() }
            .catchError { _ in .error(UserRepositoryError.failed) }
    }

    func update(userId: String, username: String) -> Single<User> {
        return provider.rx
            .request(.updateUsername(userId: userId, username: username))
            .map(MappableUser.self)
            .map { $0.toDomain() }
            .catchError { _ in .error(UserRepositoryError.failed) }
    }

    func update(userId: String, password: String) -> Single<Void> {
        return provider.rx
            .request(.updatePassword(userId: userId, password: password))
            .map { _ in () }
            .catchError { _ in .error(UserRepositoryError.failed) }
    }

    func signout() -> Single<Void> {
        return provider.rx
            .request(.signOut)
            .map { _ in () }
            .catchError { _ in .error(UserRepositoryError.failed) }
    }
}
