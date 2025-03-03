//
// 
//  SettingsContract.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/25/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import RxCocoa
import RxSwift
import UIKit
import ParylationDomain

protocol SettingsContainer {
    var authorizationService: AuthorizationService { get }
    var userService: UserService { get }
}

protocol SettingsListener: AnyObject {
    func onSignOut()
}

protocol SettingsBuilder {
    func build(listener: SettingsListener?) -> UIViewController
}

protocol SettingsRouter: AnyObject {
    func showAlert(info: AlertViewInfo)
    func terminate()
}

protocol SettingsViewModel {
    var selectTrigger: AnyObserver<IndexPath> { get }
    
    var sections: Driver<[SettingsTableSection]> { get }
}
