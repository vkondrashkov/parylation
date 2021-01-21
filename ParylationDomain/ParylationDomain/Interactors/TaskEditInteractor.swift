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
    func fetchIcons() -> Single<[Icon]>
    func fetchColors() -> Single<[Color]>
    func save(task: Task) -> Single<Void>
    func validate(title: String) -> Single<Bool>
    func validate(description: String) -> Single<Bool>
    func scheduleNotification(_ notification: PushNotification) -> Single<Void>
}

public final class TaskEditInteractorImpl {
    private let taskRepository: TaskRepository
    private let iconRepository: IconRepository
    private let colorRepository: ColorRepository
    private let credentialsValidatorService: CredentialsValidatorService
    private let pushNotificationsService: PushNotificationsService

    public init(
        taskRepository: TaskRepository,
        iconRepository: IconRepository,
        colorRepository: ColorRepository,
        credentialsValidatorService: CredentialsValidatorService,
        pushNotificationsService: PushNotificationsService
    ) {
        self.taskRepository = taskRepository
        self.iconRepository = iconRepository
        self.colorRepository = colorRepository
        self.credentialsValidatorService = credentialsValidatorService
        self.pushNotificationsService = pushNotificationsService
    }
}

// MARK: - TaskEditInteractor implementation

extension TaskEditInteractorImpl: TaskEditInteractor {
    public func fetchTask(taskId: String) -> Single<Task> {
        return taskRepository.fetchTask(taskId: taskId)
            .catchErrorJustReturn(Task(
                id: UUID().uuidString,
                iconId: "",
                colorId: "",
                title: "",
                taskDescription: "",
                date: Date()
            ))
    }

    public func fetchIcons() -> Single<[Icon]> {
        return iconRepository.fetchAll()
            .catchError { _ in return .error(TaskEditInteractorError.failed) }
    }

    public func fetchColors() -> Single<[Color]> {
        return colorRepository.fetchAll()
            .catchError { _ in return .error(TaskEditInteractorError.failed) }
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
        return pushNotificationsService.scheduleNotification(notification)
            .catchError { _ in .error(TaskEditInteractorError.failed) }
    }
}

