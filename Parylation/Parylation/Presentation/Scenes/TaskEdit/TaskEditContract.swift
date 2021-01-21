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
    var pushNotificationsService: PushNotificationsService { get }
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
    var taskTitle: AnyObserver<String> { get }
    var taskDescription: AnyObserver<String> { get }
    var taskDate: AnyObserver<Date> { get }

    var willAppearTrigger: AnyObserver<Void> { get }
    var iconSelectionTrigger: AnyObserver<IndexPath> { get }
    var colorSelectionTrigger: AnyObserver<IndexPath> { get }
    var saveTrigger: AnyObserver<Void> { get }

    var taskIcon: Driver<UIImage> { get }
    var taskColor: Driver<UIColor> { get }
    var state: Driver<TaskEditViewState> { get }
    var icons: Driver<[Icon]> { get }
    var colors: Driver<[ParylationDomain.Color]> { get }
}
