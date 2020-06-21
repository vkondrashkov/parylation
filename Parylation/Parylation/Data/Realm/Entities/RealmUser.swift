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
    dynamic var name = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func from(user: User) -> RealmUser {
        let realmUser = RealmUser()
        realmUser.userId = user.id
        realmUser.name = user.name
        return realmUser
    }
    
    func toDomain() -> User {
        return User(
            id: userId,
            name: name
        )
    }
}
