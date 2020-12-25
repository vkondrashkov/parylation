//
//  TaskViewInfo.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import ParylationDomain

struct TaskViewInfo {
    let title: String
    let taskDescription: String
    let date: String
    let isCompleted: Bool

    static func from(task: Task) -> TaskViewInfo {
        return TaskViewInfo(
            title: task.title,
            taskDescription: task.taskDescription,
            date: task.date.description,
            isCompleted: false
        )
    }
}
