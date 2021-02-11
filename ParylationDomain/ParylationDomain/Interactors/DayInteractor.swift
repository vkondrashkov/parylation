//
//  DayInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 10.02.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum DayInteractorError: Error {
    case failed
}

public protocol DayInteractor {
    func fetchTaks() -> Single<[Task]>
    func fetchIcon(id: String) -> Single<Icon>
    func fetchColor(id: String) -> Single<Color>
    func deleteTask(taskId: String) -> Single<Void>
}

public final class DayInteractorImpl {
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

// MARK: - DayInteractor implementation

extension DayInteractorImpl: DayInteractor {
    public func fetchTaks() -> Single<[Task]> {
        return taskRepository.fetchTasks()
            .catchError { _ in .error(DayInteractorError.failed) }
    }

    public func fetchIcon(id: String) -> Single<Icon> {
        return iconRepository.fetch(id: id)
            .catchError { _ in .error(DayInteractorError.failed) }
    }

    public func fetchColor(id: String) -> Single<Color> {
        return colorRepository.fetch(id: id)
            .catchError { _ in .error(DayInteractorError.failed) }
    }

    public func deleteTask(taskId: String) -> Single<Void> {
        return taskRepository.deleteTask(taskId: taskId)
            .catchError { _ in .error(DayInteractorError.failed) }
    }
}

