//
// 
//  TaskContract.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import RxCocoa
import RxSwift
import ParylationDomain
import UIKit

protocol TaskContainer {
    var taskRepository: TaskRepository { get }
    var iconRepository: IconRepository { get }
    var colorRepository: ColorRepository { get }
}

protocol TaskBuilder {
    func build(taskId: String) -> UIViewController
}

protocol TaskRouter: AnyObject {
    func showTaskEdit(taskId: String, completion: (() -> Void)?)
    func showAlert(info: AlertViewInfo)
    func terminate()
}

enum TaskViewState {
    case ready
    case loading
    case display(TaskViewInfo)
}

protocol TaskViewModel {
    var willAppearTrigger: AnyObserver<Void> { get }
    var deleteTrigger: AnyObserver<Void> { get }
    var editTrigger: AnyObserver<Void> { get }
    var completeTrigger: AnyObserver<Void> { get }

    var state: Driver<TaskViewState> { get }
}
