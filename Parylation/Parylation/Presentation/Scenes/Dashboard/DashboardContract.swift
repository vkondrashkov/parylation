//
//  DashboardContract.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

protocol DashboardContainer { }

protocol DashboardBuilder {
    func build(listener: DashboardListener?) -> UIViewController
}

protocol DashboardListener: AnyObject {
    func onSignOut()
}

protocol DashboardRouter: AnyObject {
    func showTabs()
}

protocol DashboardViewModel {
    var viewWillAppearTrigger: AnyObserver<Void> { get }
}
