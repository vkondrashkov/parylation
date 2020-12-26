//
//  TaskRepository.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 20.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum TaskRepositoryError: Error {
    case failed
    case missingData
}

public protocol TaskRepository {
    func fetchTasks() -> Single<[Task]>
    func fetchTask(taskId: String) -> Single<Task>
    func save(task: Task) -> Single<Void>
    func deleteTask(taskId: String) -> Single<Void>
}
