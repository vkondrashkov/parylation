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
import ObjectMapper

final class UserRepositoryImpl: UserRepository {
    private let provider: MoyaProvider<ParylationAPI>
    
    init(provider: MoyaProvider<ParylationAPI>) {
        self.provider = provider
    }
    
    func registerUser(login: String, password: String) -> Single<Void> {
        return provider.rx
            .request(.signUp(login: login, password: password))
            .map { _ in () }
            .catchError { _ in .error(UserRepositoryError.failed) }
    }
    
    func authorizeUser(login: String, password: String) -> Single<User> {
        return provider.rx
            .request(.signIn(login: login, password: password))
            .mapJSON()
            .flatMap { jsonObject in
                // TODO: Replace with Codable
                return .just(User(id: UUID().uuidString, name: "Vladislav"))
            }
    }
}
