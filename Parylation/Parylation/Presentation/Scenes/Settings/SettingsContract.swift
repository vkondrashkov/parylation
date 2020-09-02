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
import ReactiveKit
import Bond

protocol SettingsDependency {
    var settingsNavigationController: UINavigationController { get }
}

protocol SettingsBuilder {
    func build() -> UIViewController
}

protocol SettingsRouter: AnyObject { }

protocol SettingsViewModel {
    var selectTrigger: Subject<IndexPath, Never> { get }
    
    var sections: SafeSignal<Array2D<String?, SettingsTableItem>> { get }
}
