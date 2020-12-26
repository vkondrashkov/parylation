//
//  TaskEditViewInfo.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Foundation
import ParylationDomain

struct TaskEditViewInfo {
    let title: String
    let taskDescription: String
    let date: Date

    static func from(task: Task) -> TaskEditViewInfo {
        return TaskEditViewInfo(
            title: task.title,
            taskDescription: task.taskDescription,
            date: task.date
        )
    }
}
