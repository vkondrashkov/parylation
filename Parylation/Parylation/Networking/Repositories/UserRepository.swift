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
        let registerUser = PassthroughSubject<Void, UserRepositoryError>()
        provider.request(
            .signUp(login: login, password: password),
            completion: { response in
                switch response {
                case .success:
                    registerUser.receive()
                    registerUser.receive(completion: .finished)
                case .failure:
                    registerUser.receive(completion: .failure(.failed))
                }
            }
        )
        return registerUser.toSignal()
    }
    
    func authorizeUser(login: String, password: String) -> Signal<User, UserRepositoryError> {
        let authorizeUser = PassthroughSubject<User, UserRepositoryError>()
        provider.request(
            .signIn(login: login, password: password),
            completion: { response in
                switch response {
                case .success(let data):
                    guard let json = try? data.mapJSON() as? [String: Any] else {
                        authorizeUser.receive(completion: .failure(.failed))
                        return
                    }
                    guard let mappableUser = Mapper<MappableUser>().map(JSON: json) else {
                        authorizeUser.receive(completion: .failure(.missingData))
                        return
                    }
                    authorizeUser.receive(mappableUser.toDomain())
                    authorizeUser.receive(completion: .finished)
                case .failure:
                    authorizeUser.receive(completion: .failure(.failed))
                }
            }
        )
        return authorizeUser.toSignal()
    }
}
