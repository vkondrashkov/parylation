//
//  TaskRepositoryImpl.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 20.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RealmSwift
import RxSwift
import ParylationDomain

final class TaskRepositoryImpl: TaskRepository {
    private let realm: Realm

    init(realm: Realm) {
        self.realm = realm
    }

    func fetchTasks() -> Single<[Task]> {
        let tasks = realm.objects(RealmTask.self)
        return .just(tasks.map { $0.toDomain() })
    }

    func save(task: Task) -> Single<Void> {
        return .create { [weak self] single in
            guard let self = self else {
                single(.error(TaskRepositoryError.failed))
                return Disposables.create()
            }
            let realmTask = RealmTask.from(task: task)
            do {
                try self.realm.write {
                    self.realm.add(realmTask)
                }
            } catch {
                single(.error(TaskRepositoryError.failed))
            }
            guard self.realm.object(ofType: RealmTask.self, forPrimaryKey: realmTask.id) != nil else {
                single(.error(TaskRepositoryError.failed))
                return Disposables.create()
            }
            single(.success(()))
            return Disposables.create()
        }
    }

    func deleteTask(taskId: String) -> Single<Void> {
        return .create { [weak self] single in
            guard let self = self else {
                single(.error(TaskRepositoryError.failed))
                return Disposables.create()
            }
            let fetched = self.realm.objects(RealmTask.self).filter { $0.taskId == taskId }.first
            guard let deletingTask = fetched else {
                single(.error(TaskRepositoryError.missingData))
                return Disposables.create()
            }
            let deletingTaskId = deletingTask.id
            do {
                try self.realm.write {
                    self.realm.delete(deletingTask)
                }
            } catch {
                single(.error(TaskRepositoryError.failed))
            }
            guard self.realm.object(ofType: RealmTask.self, forPrimaryKey: deletingTaskId) == nil else {
                single(.error(TaskRepositoryError.failed))
                return Disposables.create()
            }
            single(.success(()))
            return Disposables.create()
        }
    }
}
