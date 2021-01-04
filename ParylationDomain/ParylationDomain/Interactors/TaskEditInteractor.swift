//
//  TaskEditInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum TaskEditInteractorError: Error {
    case failed
}

public protocol TaskEditInteractor {
    func fetchTask(taskId: String) -> Single<Task>
    func save(task: Task) -> Single<Void>
    func validate(title: String) -> Single<Bool>
    func validate(description: String) -> Single<Bool>
}

public final class TaskEditInteractorImpl {
    private let taskRepository: TaskRepository
    private let credentialsValidatorUseCase: CredentialsValidatorUseCase

    public init(
        taskRepository: TaskRepository,
        credentialsValidatorUseCase: CredentialsValidatorUseCase
    ) {
        self.taskRepository = taskRepository
        self.credentialsValidatorUseCase = credentialsValidatorUseCase
    }
}

// MARK: - TaskEditInteractor implementation

extension TaskEditInteractorImpl: TaskEditInteractor {
    public func fetchTask(taskId: String) -> Single<Task> {
        return taskRepository.fetchTask(taskId: taskId)
            .catchErrorJustReturn(Task(
                id: UUID().uuidString,
                title: "",
                taskDescription: "",
                date: Date()
            ))
    }

    public func save(task: Task) -> Single<Void> {
        return taskRepository.save(task: task)
            .catchError { _ in .error(TaskEditInteractorError.failed) }
    }

    public func validate(title: String) -> Single<Bool> {
        return credentialsValidatorUseCase.validate(taskTitle: title)
            .catchError { _ in .error(TaskEditInteractorError.failed) }
    }

    public func validate(description: String) -> Single<Bool> {
        return credentialsValidatorUseCase.validate(taskDescription: description)
            .catchError { _ in .error(TaskEditInteractorError.failed) }
    }
}

