//
//  RealmUser.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RealmSwift
import ParylationDomain

@objcMembers
final class RealmUser: Object {
    dynamic var id = UUID().uuidString
    
    dynamic var userId = ""
    dynamic var email = ""
    dynamic var username = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func from(user: User) -> RealmUser {
        let realmUser = RealmUser()
        realmUser.userId = user.id
        realmUser.email = user.email
        realmUser.username = user.username
        return realmUser
    }
    
    func toDomain() -> User {
        return User(
            id: userId,
            email: email,
            username: username
        )
    }
}
