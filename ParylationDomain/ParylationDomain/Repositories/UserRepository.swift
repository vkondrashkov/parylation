//
//  UserRepository.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 6/20/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum UserRepositoryError: Error {
    case failed
    case userAlreadyExists
    case missingData
}

public protocol UserRepository {
    func registerUser(login: String, password: String) -> Single<Void>
    func authorizeUser(login: String, password: String) -> Single<User>
}
