//
// 
//  DayContract.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 10.02.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//
//

import UIKit
import RxCocoa
import RxSwift
import ParylationDomain

protocol DayContainer {
    var taskRepository: TaskRepository { get }
    var iconRepository: IconRepository { get }
    var colorRepository: ColorRepository { get }
}

protocol DayBuilder {
    func build() -> UIViewController
}

protocol DayRouter: AnyObject { }

protocol DayViewModel { }
