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
}

protocol HomeBuilder: AnyObject {
    func build() -> UIViewController
}

protocol HomeRouter: AnyObject {
    func showTask(taskId: String)
}

protocol HomeViewModel {
    var reloadTrigger: AnyObserver<Void> { get }
    var createTrigger: AnyObserver<Void> { get }
    var selectTrigger: AnyObserver<IndexPath> { get }
    var deleteTrigger: AnyObserver<IndexPath> { get }

    var sections: Driver<[HomeTableSection]> { get }
}
