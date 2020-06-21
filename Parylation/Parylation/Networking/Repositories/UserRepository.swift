//
//  UserRepository.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import ReactiveKit
import Moya
import ParylationDomain
import ObjectMapper

final class UserRepositoryImpl: UserRepository {
    private let provider: MoyaProvider<ParylationAPI>
    
    init(provider: MoyaProvider<ParylationAPI>) {
        self.provider = provider
    }
    
    func registerUser(login: String, password: String) -> Signal<Void, UserRepositoryError> {
        return provider.reactive
            .request(.signUp(login: login, password: password))
            .eraseType()
            .mapError { _ in
                return .failed
            }
    }
    
    func authorizeUser(login: String, password: String) -> Signal<User, UserRepositoryError> {
        let authorizeUser: Signal<MappableUser, UserRepositoryError> = provider.reactive
            .request(.signIn(login: login, password: password))
            .mapError { _ -> UserRepositoryError in
                return .failed
            }
        
        return authorizeUser
            .map {
                $0.toDomain()
            }
    }
}
