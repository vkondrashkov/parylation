//
//  WelcomeContract.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxCocoa
import RxSwift
import ParylationDomain
import UIKit

protocol WelcomeContainer {
    var window: UIWindow { get }
}

protocol WelcomeBuilder: AnyObject {
    func build() -> UIViewController
}

protocol WelcomeRouter: AnyObject {
    func showDashboard()
    func showSignUp()
    func showSignIn()
}

protocol WelcomeViewModel {
    var signUpTrigger: AnyObserver<Void> { get }
    var signInTrigger: AnyObserver<Void> { get }
}
