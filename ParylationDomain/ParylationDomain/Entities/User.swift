//
//  User.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 6/20/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

public struct User {
    public let id: String
    public let name: String
    
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

extension User: Equatable {
    public static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name
    }
}
