//
//  TaskEditViewInfo.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit
import ParylationDomain

struct TaskEditViewInfo {
    let icon: UIImage
    let color: UIColor
    let title: String
    let taskDescription: String
    let date: Date

    static func from(task: Task) -> TaskEditViewInfo {
        return TaskEditViewInfo(
            icon: Asset.taskEditList.image.withRenderingMode(.alwaysTemplate), // TEMP
            color: Color.gigas,             // TEMP
            title: task.title,
            taskDescription: task.taskDescription,
            date: task.date
        )
    }
}
