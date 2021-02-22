//
//  TaskEditData.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 21.02.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import Foundation
import ParylationDomain

struct TaskEditData {
    let id: String?
    let iconId: String?
    let colorId: String?
    let title: String?
    let taskDescription: String?
    let date: Date?

    init(
        id: String? = nil,
        iconId: String? = nil,
        colorId: String? = nil,
        title: String? = nil,
        taskDescription: String? = nil,
        date: Date? = nil
    ) {
        self.id = id
        self.iconId = iconId
        self.colorId = colorId
        self.title = title
        self.taskDescription = taskDescription
        self.date = date
    }

    static func from(task: Task) -> TaskEditData {
        return .init(
            id: task.id,
            iconId: task.iconId,
            colorId: task.colorId,
            title: task.title,
            taskDescription: task.taskDescription,
            date: task.date
        )
    }
}
