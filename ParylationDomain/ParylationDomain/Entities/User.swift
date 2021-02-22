//
//  User.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 6/20/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

public struct User {
    public let id: String
    public let email: String
    public let username: String
    
    public init(
        id: String,
        email: String,
        username: String
    ) {
        self.id = id
        self.email = email
        self.username = username
    }
}

extension User: Equatable {
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
            && lhs.email == rhs.email
            && lhs.username == rhs.username
    }
}
