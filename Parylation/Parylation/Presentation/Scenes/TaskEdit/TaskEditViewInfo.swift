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
    let title: String?
    let taskDescription: String?
    let date: Date?
    let image: UIImage
    let color: UIColor

    static func from(
        data: TaskEditData,
        icon: Icon,
        color: ParylationDomain.Color
    ) -> TaskEditViewInfo {
        return .init(
            title: data.title,
            taskDescription: data.taskDescription,
            date: data.date,
            image: icon.image,
            color: color.value
        )
    }
}
