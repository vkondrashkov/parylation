//
//  UserRepositoryImpl.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import ReactiveKit
import ParylationDomain

final class UserRepositoryImpl {
    
}

extension UserRepositoryImpl: UserRepository {
    func fetchCurrentUser() -> Signal<User, UserRepositoryError> {
        return Signal<User, UserRepositoryError> { observer in
            let user = User(id: "foo", name: "bar")
            observer.receive(user)
            return SimpleDisposable()
        }
    }
}
