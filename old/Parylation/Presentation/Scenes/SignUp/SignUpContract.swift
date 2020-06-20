//
//  SignUpContract.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit
import UIKit

protocol SignUpDependency {
    var authNavigationController: UINavigationController { get }
}

protocol SignUpBuilder: AnyObject {
    func build() -> UIViewController
}

protocol SignUpRouter: AnyObject {
    func showSignIn()
}

protocol SignUpViewModel { }
