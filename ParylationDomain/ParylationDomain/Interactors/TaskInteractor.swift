//
//  TaskInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum TaskInteractorError: Error {
    case failed
}

public protocol TaskInteractor {
    func fetchTask(taskId: String) -> Single<Task>
    func deleteTask(taskId: String) -> Single<Void>
}

public final class TaskInteractorImpl {
    private let taskRepository: TaskRepository

    public init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
}

// MARK: - TaskInteractor implementation

extension TaskInteractorImpl: TaskInteractor {
    public func fetchTask(taskId: String) -> Single<Task> {
        return taskRepository.fetchTask(taskId: taskId)
            .catchError { _ in return .error(TaskInteractorError.failed) }
    }

    public func deleteTask(taskId: String) -> Single<Void> {
        return taskRepository.deleteTask(taskId: taskId)
            .catchError { _ in return .error(TaskInteractorError.failed) }
    }
}

