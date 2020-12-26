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
    func deleteTask(taskId: String) -> Single<Void>

    // TEMP:
    func createTask(task: Task) -> Single<Void>
}

public final class HomeInteractorImpl {
    private let taskRepository: TaskRepository

    public init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
}

// MARK: - HomeInteractor implementation

extension HomeInteractorImpl: HomeInteractor {
    public func fetchTaks() -> Single<[Task]> {
        return taskRepository.fetchTasks()
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
