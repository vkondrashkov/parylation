//
//  SignInContract.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//


import RxCocoa
import RxSwift
import ParylationDomain
import UIKit

protocol SignInContainer {
    var authorizationService: AuthorizationService { get }
}

protocol SignInListener: AnyObject {
    func onSignInFinish()
}

protocol SignInBuilder: AnyObject {
    func build(listener: (SignInListener & SignUpListener)?) -> UIViewController
}

protocol SignInRouter: AnyObject {
    func showSignUp()
    func finishSignIn()
}

protocol SignInViewModel {
    var email: AnyObserver<String> { get }
    var password: AnyObserver<String> { get }
    var signInTrigger: AnyObserver<Void> { get }
    var signUpTrigger: AnyObserver<Void> { get }

    var emailError: Driver<String?> { get }
}
