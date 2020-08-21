//
//  AppComponent.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit
import RealmSwift

final class AppComponent: RootDependency {
    let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
}
