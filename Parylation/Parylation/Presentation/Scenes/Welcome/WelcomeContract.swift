//
//  WelcomeContract.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit
import UIKit

protocol WelcomeDependency {
    var navigationController: UINavigationController { get }
}

protocol WelcomeBuilder: AnyObject {
    func build() -> UIViewController
}

protocol WelcomeRouter: AnyObject {
    func showSignUp()
    func showSignIn()
}

protocol WelcomeViewModel {
    var signUpTrigger: Subject<Void, Never> { get }
    var signInTrigger: Subject<Void, Never> { get }
}
