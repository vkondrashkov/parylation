//
// 
//  TaskRouter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import UIKit

final class TaskRouterImpl {
    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - TaskRouter implementation

extension TaskRouterImpl: TaskRouter {
    func showTaskEdit(taskId: String, completion: (() -> Void)?) {

    }
    
    func terminate() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
