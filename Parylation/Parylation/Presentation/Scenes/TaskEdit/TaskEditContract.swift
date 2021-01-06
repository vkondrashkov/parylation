//
// 
//  TaskEditContract.swift
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

protocol TaskEditContainer {
    var taskRepository: TaskRepository { get }
    var pushNotificationsUseCase: PushNotificationsUseCase { get }
}

protocol TaskEditBuilder {
    func build(taskId: String?) -> UIViewController
}

protocol TaskEditRouter: AnyObject {
    func terminate()
}

enum TaskEditViewState {
    case ready
    case loading
    case display(TaskEditViewInfo)
}

protocol TaskEditViewModel {
    var willAppearTrigger: AnyObserver<Void> { get }
    var taskTitle: AnyObserver<String> { get }
    var taskDescription: AnyObserver<String> { get }
    var taskDate: AnyObserver<Date> { get }
    var saveTrigger: AnyObserver<Void> { get }

    var state: Driver<TaskEditViewState> { get }
}
