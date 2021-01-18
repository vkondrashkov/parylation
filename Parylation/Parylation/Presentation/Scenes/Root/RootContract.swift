//
//  RootContract.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import ParylationDomain
import RxCocoa
import RxSwift
import UIKit

protocol RootContainer {
    var authorizationService: AuthorizationService { get }
    var pushNotificationsService: PushNotificationsService { get }
}

protocol RootBuilder: AnyObject {
    func build() -> UIViewController
}

protocol RootRouter: AnyObject {
    func showWelcome()
    func showDashboard()
}

protocol RootViewModel {
    var viewDidAppearTrigger: AnyObserver<Void> { get }
}
