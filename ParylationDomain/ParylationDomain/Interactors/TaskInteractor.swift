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
    func fetchIcon(id: String) -> Single<Icon>
    func fetchColor(id: String) -> Single<Color>
    func deleteTask(taskId: String) -> Single<Void>
}

public final class TaskInteractorImpl {
    private let taskRepository: TaskRepository
    private let iconRepository: IconRepository
    private let colorRepository: ColorRepository

    public init(
        taskRepository: TaskRepository,
        iconRepository: IconRepository,
        colorRepository: ColorRepository
    ) {
        self.taskRepository = taskRepository
        self.iconRepository = iconRepository
        self.colorRepository = colorRepository
    }
}

// MARK: - TaskInteractor implementation

extension TaskInteractorImpl: TaskInteractor {
    public func fetchTask(taskId: String) -> Single<Task> {
        return taskRepository.fetchTask(taskId: taskId)
            .catchError { _ in return .error(TaskInteractorError.failed) }
    }

    public func fetchIcon(id: String) -> Single<Icon> {
        return iconRepository.fetch(id: id)
            .catchError { _ in return .error(TaskInteractorError.failed) }
    }

    public func fetchColor(id: String) -> Single<Color> {
        return colorRepository.fetch(id: id)
            .catchError { _ in return .error(TaskEditInteractorError.failed) }
    }

    public func deleteTask(taskId: String) -> Single<Void> {
        return taskRepository.deleteTask(taskId: taskId)
            .catchError { _ in return .error(TaskInteractorError.failed) }
    }
}

