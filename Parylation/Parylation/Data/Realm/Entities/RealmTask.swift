//
//  RealmTask.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 20.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RealmSwift
import ParylationDomain

@objcMembers
final class RealmTask: Object {
    dynamic var id = UUID().uuidString

    dynamic var iconId = "task-icon-list"
    dynamic var colorId = "task-color-gigas"
    dynamic var taskId = ""
    dynamic var title = ""
    dynamic var taskDescription = ""
    dynamic var date = Date()

    override class func primaryKey() -> String? {
        return "id"
    }

    static func from(task: Task) -> RealmTask {
        let realmTask = RealmTask()
        realmTask.taskId = task.id
        realmTask.iconId = task.iconId
        realmTask.colorId = task.colorId
        realmTask.title = task.title
        realmTask.taskDescription = task.taskDescription
        realmTask.date = task.date
        return realmTask
    }

    func toDomain() -> Task {
        return Task(
            id: taskId,
            iconId: iconId,
            colorId: colorId,
            title: title,
            taskDescription: taskDescription,
            date: date
        )
    }
}
