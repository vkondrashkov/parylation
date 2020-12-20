//
//  AuthorizedUserRepository.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 6/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum AuthorizedUserRepositoryError: Error {
    case failed
    case missingData
}

public protocol AuthorizedUserRepository {
    func fetchUser() -> Single<User>
    func saveUser(user: User) -> Single<Void>
}
