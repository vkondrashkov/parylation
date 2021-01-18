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
    func scheduleNotification(_ notification: PushNotification) -> Single<Void>
}

public final class TaskEditInteractorImpl {
    private let taskRepository: TaskRepository
    private let credentialsValidatorService: CredentialsValidatorService
    private let pushNotificationsUseCase: PushNotificationsUseCase

    public init(
        taskRepository: TaskRepository,
        credentialsValidatorService: CredentialsValidatorService,
        pushNotificationsUseCase: PushNotificationsUseCase
    ) {
        self.taskRepository = taskRepository
        self.credentialsValidatorService = credentialsValidatorService
        self.pushNotificationsUseCase = pushNotificationsUseCase
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
        return credentialsValidatorService.validate(taskTitle: title)
            .catchError { _ in .error(TaskEditInteractorError.failed) }
    }

    public func validate(description: String) -> Single<Bool> {
        return credentialsValidatorService.validate(taskDescription: description)
            .catchError { _ in .error(TaskEditInteractorError.failed) }
    }

    public func scheduleNotification(_ notification: PushNotification) -> Single<Void> {
        return pushNotificationsUseCase.scheduleNotification(notification)
            .catchError { _ in .error(TaskEditInteractorError.failed) }
    }
}

