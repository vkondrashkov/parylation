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
import ParylationDomain

protocol SignUpContainer {
    var authorizationUseCase: AuthorizationUseCase { get }
}

protocol SignUpListener: AnyObject {
    func onSignUpFinish()
}

protocol SignUpBuilder: AnyObject {
    func build(listener: (SignUpListener & SignInListener)?) -> UIViewController
}

protocol SignUpRouter: AnyObject {
    func showSignIn()
    func finishSignUp()
}

protocol SignUpViewModel {
    var signUpTrigger: Subject<Void, Never> { get }
    var signInTrigger: Subject<Void, Never> { get }
}
