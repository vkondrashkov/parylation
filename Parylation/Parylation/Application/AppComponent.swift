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
    unowned let window: UIWindow
    let realm: Realm
    
    init(
        window: UIWindow,
        realm: Realm
    ) {
        self.window = window
        self.realm = realm
    }
}
