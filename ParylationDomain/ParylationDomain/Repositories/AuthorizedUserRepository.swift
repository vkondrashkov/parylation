//
//  AuthorizedUserRepository.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 6/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import ReactiveKit

public enum AuthorizedUserRepositoryError: Error {
    case failed
    case missingData
}

public protocol AuthorizedUserRepository {
    func fetchUser() -> Signal<User, AuthorizedUserRepositoryError>
    func saveUser(user: User) -> Signal<Void, AuthorizedUserRepositoryError>
}
