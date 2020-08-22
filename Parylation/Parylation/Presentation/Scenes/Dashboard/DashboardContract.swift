//
//  DashboardContract.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit
import UIKit

protocol DashboardDependency { }

protocol DashboardBuilder {
    func build() -> UIViewController
}

protocol DashboardRouter: AnyObject {
    func showTabs()
}

protocol DashboardViewModel {
    var viewWillAppearTrigger: Subject<Void, Never> { get }
}
