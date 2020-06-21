//
//  RootContract.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit
import UIKit
import RealmSwift

protocol RootDependency {
    var window: UIWindow { get }
    var realm: Realm { get }
}

protocol RootBuilder: AnyObject {
    func build() -> UIViewController
}

protocol RootRouter: AnyObject {
    func showSignUp()
    func showDashboard()
}

protocol RootViewModel {
    var viewDidAppearTrigger: PassthroughSubject<Void, Never> { get }
}
