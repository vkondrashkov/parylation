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
import ParylationDomain

protocol SignInContainer {
    var authorizationUseCase: AuthorizationUseCase { get }
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
    var signInTrigger: Subject<Void, Never> { get }
    var signUpTrigger: Subject<Void, Never> { get }
}
