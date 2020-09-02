//
//  HomeContract.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit
import UIKit

protocol HomeContainer { }

protocol HomeBuilder: AnyObject {
    func build(navigationController: UINavigationController) -> UIViewController
}

protocol HomeRouter: AnyObject { }

protocol HomeViewModel { }
