//
//  UserRepository.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import ReactiveKit

enum UserRepositoryError: Error {
    case failed
    case missingData
}

protocol UserRepository {
    func fetchCurrentUser() -> Signal<User, UserRepositoryError>
}
