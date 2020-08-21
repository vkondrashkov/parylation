//
//  SignInContract.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit
import UIKit

protocol SignInDependency {
    var authNavigationController: UINavigationController { get }
}

protocol SignInBuilder: AnyObject {
    func build() -> UIViewController
}

protocol SignInRouter: AnyObject {
    func showSignUp()
}

protocol SignInViewModel {
    var signUpTrigger: Subject<Void, Never> { get }
}
