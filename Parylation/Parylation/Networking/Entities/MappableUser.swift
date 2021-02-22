//
//  MappableUser.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import ParylationDomain

class MappableUser: Codable {
    let id: String
    let email: String
    let username: String
    
    func toDomain() -> User {
        return User(
            id: id,
            email: email,
            username: username
        )
    }
}
