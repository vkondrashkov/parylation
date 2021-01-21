//
//  HomeContract.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxCocoa
import RxSwift
import ParylationDomain
import UIKit

protocol HomeContainer {
    var taskRepository: TaskRepository { get }
    var iconRepository: IconRepository { get }
    var colorRepository: ColorRepository { get }
}

protocol HomeBuilder: AnyObject {
    func build() -> UIViewController
}

protocol HomeRouter: AnyObject {
    func showTask(taskId: String)
    func showTaskCreation()
}

protocol HomeViewModel {
    var reloadTrigger: AnyObserver<Void> { get }
    var createTrigger: AnyObserver<Void> { get }
    var willDisplayItemTrigger: AnyObserver<IndexPath> { get }
    var selectTrigger: AnyObserver<IndexPath> { get }
    var deleteTrigger: AnyObserver<IndexPath> { get }
    
    var itemIcon: Driver<(Icon, IndexPath)> { get }
    var itemColor: Driver<(ParylationDomain.Color, IndexPath)> { get }
    var sections: Driver<[HomeTableSection]> { get }
}
