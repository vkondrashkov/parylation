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
    var realm: Realm { get }
    var window: UIWindow { get }
}

protocol RootBuilder: AnyObject {
    func build() -> UIViewController
}

protocol RootRouter: AnyObject {
    func showWelcome()
    func showDashboard()
}

protocol RootViewModel {
    var viewDidAppearTrigger: PassthroughSubject<Void, Never> { get }
}
