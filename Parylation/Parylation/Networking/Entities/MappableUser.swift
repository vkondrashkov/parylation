//
//  MappableUser.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import ObjectMapper
import ParylationDomain

class MappableUser: ImmutableMappable {
    let id: String
    let name: String
    
    required init(map: Map) throws {
        id = try map.value("id")
        name = try map.value("name")
    }
    
    func toDomain() -> User {
        return User(
            id: id,
            name: name
        )
    }
}
