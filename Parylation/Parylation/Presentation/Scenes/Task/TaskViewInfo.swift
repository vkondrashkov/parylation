//
//  TaskViewInfo.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit
import ParylationDomain

struct TaskViewInfo {
    let icon: UIImage
    let color: UIColor
    let title: String
    let taskDescription: String
    let date: String
    let isCompleted: Bool

    static func from(task: Task, icon: Icon, color: ParylationDomain.Color) -> TaskViewInfo {
        return TaskViewInfo(
            icon: icon.image,
            color: color.value,
            title: task.title,
            taskDescription: task.taskDescription,
            date: CommonTextFormatter().dateToString(task.date),
            isCompleted: false
        )
    }
}
