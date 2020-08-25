//
// 
//  SettingsContract.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/25/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import UIKit

protocol SettingsDependency {
    var navigationController: UINavigationController { get }
}

protocol SettingsBuilder {
    func build() -> UIViewController
}

protocol SettingsRouter: AnyObject { }

protocol SettingsViewModel { }
