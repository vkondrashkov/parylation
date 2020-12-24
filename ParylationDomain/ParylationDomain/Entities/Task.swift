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
    public let title: String
    public let taskDescription: String
    public let date: Date

    public init(
        id: String,
        title: String,
        taskDescription: String,
        date: Date
    ) {
        self.id = id
        self.title = title
        self.taskDescription = taskDescription
        self.date = date
    }
}

// MARK: - Equatable implementation

extension Task: Equatable {
    public static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
            && lhs.title == rhs.title
            && lhs.taskDescription == rhs.taskDescription
            && lhs.date == rhs.date
    }
}
