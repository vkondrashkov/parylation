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
    func build(date: Date) -> UIViewController
}

protocol DayRouter: AnyObject {
    func showTask(taskId: String)
    func showTaskEdit(data: TaskEditData)
}

protocol DayViewModel {
    var reloadTrigger: AnyObserver<Void> { get }
    var createTrigger: AnyObserver<Void> { get }
    var selectTrigger: AnyObserver<IndexPath> { get }

    var items: Driver<[DayTableItem]> { get }
    var selectedDay: Driver<String> { get }
}
