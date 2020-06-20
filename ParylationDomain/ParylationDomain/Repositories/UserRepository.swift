//
//  UserRepository.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 6/20/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import ReactiveKit

public enum UserRepositoryError: Error {
    case failed
    case missingData
}

public protocol UserRepository {
    func fetchCurrentUser() -> Signal<User, UserRepositoryError>
}
