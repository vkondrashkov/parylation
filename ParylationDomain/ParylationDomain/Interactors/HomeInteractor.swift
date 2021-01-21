//
//  HomeInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 8/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum HomeInteractorError: Error {
    case failed
}

public protocol HomeInteractor {
    func fetchTaks() -> Single<[Task]>
    func fetchIcon(id: String) -> Single<Icon>
    func fetchColor(id: String) -> Single<Color>
    func deleteTask(taskId: String) -> Single<Void>

    // TEMP:
    func createTask(task: Task) -> Single<Void>
}

public final class HomeInteractorImpl {
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

// MARK: - HomeInteractor implementation

extension HomeInteractorImpl: HomeInteractor {
    public func fetchTaks() -> Single<[Task]> {
        return taskRepository.fetchTasks()
            .catchError { _ in .error(HomeInteractorError.failed) }
    }

    public func fetchIcon(id: String) -> Single<Icon> {
        return iconRepository.fetch(id: id)
            .catchError { _ in .error(HomeInteractorError.failed) }
    }

    public func fetchColor(id: String) -> Single<Color> {
        return colorRepository.fetch(id: id)
            .catchError { _ in .error(HomeInteractorError.failed) }
    }

    public func createTask(task: Task) -> Single<Void> {
        return taskRepository.save(task: task)
            .catchError { _ in .error(HomeInteractorError.failed) }
    }

    public func deleteTask(taskId: String) -> Single<Void> {
        return taskRepository.deleteTask(taskId: taskId)
            .catchError { _ in .error(HomeInteractorError.failed) }
    }
}
