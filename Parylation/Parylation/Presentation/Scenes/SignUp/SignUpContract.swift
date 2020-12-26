//
//  SignUpContract.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxCocoa
import RxSwift
import ParylationDomain
import UIKit

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
    var signUpTrigger: AnyObserver<Void> { get }
    var signInTrigger: AnyObserver<Void> { get }
}
