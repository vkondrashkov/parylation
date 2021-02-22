//
//  TaskEditViewInfo.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

struct TaskEditViewInfo {
    let title: String?
    let taskDescription: String?
    let date: Date?

    static func from(data: TaskEditData) -> TaskEditViewInfo {
        return .init(
            title: data.title,
            taskDescription: data.taskDescription,
            date: data.date
        )
    }
}
