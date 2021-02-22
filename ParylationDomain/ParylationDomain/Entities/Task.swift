//
//  Task.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 20.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

public struct Task {
    public let id: String
    public let iconId: String
    public let colorId: String
    public let title: String
    public let taskDescription: String
    public let date: Date

    public init(
        id: String,
        iconId: String,
        colorId: String,
        title: String,
        taskDescription: String,
        date: Date
    ) {
        self.id = id
        self.iconId = iconId
        self.colorId = colorId
        self.title = title
        self.taskDescription = taskDescription
        self.date = date
    }
}

// MARK: - Equatable implementation

extension Task: Equatable {
    public static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
            && lhs.iconId == rhs.iconId
            && lhs.colorId == rhs.colorId
            && lhs.title == rhs.title
            && lhs.taskDescription == rhs.taskDescription
            && lhs.date == rhs.date
    }
}
