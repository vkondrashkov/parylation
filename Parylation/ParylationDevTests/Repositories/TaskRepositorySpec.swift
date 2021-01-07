//
//  TaskRepositorySpec.swift
//  ParylationDevTests
//
//  Created by Vladislav Kondrashkov on 24.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RealmSwift
import RxSwift
import RxTest
import ParylationDomain
import Quick
import Nimble

@testable import ParylationDev

final class TaskRepositorySpec: QuickSpec {
    override func spec() {
        var scheduler: TestScheduler!
        var taskRepository: TaskRepository!
        var disposeBag: DisposeBag!

        beforeSuite {
            Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        }

        beforeEach {
            scheduler = TestScheduler(initialClock: 0)
            taskRepository = TaskRepositoryImpl(realm: try! Realm())
            disposeBag = DisposeBag()
            let realm = try! Realm()
            try? realm.write {
                realm.deleteAll()
            }
        }

        describe("on fetchTasks()") {
            context("when storage is not empty") {
                beforeEach {
                    let realm = try! Realm()
                    let task = Task(id: "1", title: "foo", taskDescription: "bar", date: Date(timeIntervalSince1970: 0))
                    try? realm.write {
                        realm.add(RealmTask.from(task: task))
                    }
                }

                it("should contain value") {
                    let observer = scheduler.createObserver([Task].self)
                    taskRepository.fetchTasks()
                        .asObservable()
                        .bind(to: observer)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<[Task]>>] = [
                        .next(0, [Task(id: "1", title: "foo", taskDescription: "bar", date: Date(timeIntervalSince1970: 0))]),
                        .completed(0)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }

            context("when storage is empty") {
                it("shouldn't contain value") {
                    let observer = scheduler.createObserver([Task].self)
                    taskRepository.fetchTasks()
                        .asObservable()
                        .bind(to: observer)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<[Task]>>] = [
                        .next(0, []),
                        .completed(0)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }
        }

        describe("on save(:)") {
            var observer: TestableObserver<[Task]>!
            beforeEach {
                observer = scheduler.createObserver([Task].self)
                scheduler
                    .createColdObservable([
                        .next(10, Task(id: "2", title: "new", taskDescription: "task", date: Date(timeIntervalSince1970: 0)))
                    ])
                    .flatMap { taskRepository.save(task: $0) }
                    .subscribe(onNext: { })
                    .disposed(by: disposeBag)
                scheduler
                    .createColdObservable([
                        .next(0, ()),
                        .next(10, ())
                    ])
                    .flatMap { taskRepository.fetchTasks() }
                    .bind(onNext: observer.onNext)
                    .disposed(by: disposeBag)
            }

            context("when storage has values") {
                beforeEach {
                    let realm = try! Realm()
                    let task = Task(id: "1", title: "foo", taskDescription: "bar", date: Date(timeIntervalSince1970: 0))
                    try? realm.write {
                        realm.add(RealmTask.from(task: task))
                    }
                }

                it("should store all values") {
                    let expected: [Recorded<Event<[Task]>>] = [
                        .next(0, [
                            Task(id: "1", title: "foo", taskDescription: "bar", date: Date(timeIntervalSince1970: 0))
                        ]),
                        .next(10, [
                            Task(id: "2", title: "new", taskDescription: "task", date: Date(timeIntervalSince1970: 0)),
                            Task(id: "1", title: "foo", taskDescription: "bar", date: Date(timeIntervalSince1970: 0))
                        ])
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }

            context("when storage has same values") {
                beforeEach {
                    let realm = try! Realm()
                    let task = Task(id: "2", title: "foo", taskDescription: "bar", date: Date(timeIntervalSince1970: 0))
                    try? realm.write {
                        realm.add(RealmTask.from(task: task))
                    }
                }

                it("should override value") {
                    let expected: [Recorded<Event<[Task]>>] = [
                        .next(0, [
                            Task(id: "2", title: "foo", taskDescription: "bar", date: Date(timeIntervalSince1970: 0))
                        ]),
                        .next(10, [
                            Task(id: "2", title: "new", taskDescription: "task", date: Date(timeIntervalSince1970: 0))
                        ])
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }

            context("when storage is empty") {
                it("should store value") {
                    let expected: [Recorded<Event<[Task]>>] = [
                        .next(0, []),
                        .next(10, [
                            Task(id: "2", title: "new", taskDescription: "task", date: Date(timeIntervalSince1970: 0))
                        ])
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }
        }

        describe("on deleteTask(:)") {
            var observer: TestableObserver<[Task]>!
            beforeEach {
                observer = scheduler.createObserver([Task].self)
                scheduler
                    .createColdObservable([
                        .next(10, "1")
                    ])
                    .flatMap { taskRepository.deleteTask(taskId: $0) }
                    .subscribe(onNext: { })
                    .disposed(by: disposeBag)
                scheduler
                    .createColdObservable([
                        .next(0, ()),
                        .next(10, ())
                    ])
                    .flatMap { taskRepository.fetchTasks() }
                    .bind(onNext: observer.onNext)
                    .disposed(by: disposeBag)
            }

            context("when storage contains deleting value") {
                beforeEach {
                    let realm = try! Realm()
                    let task = Task(id: "1", title: "foo", taskDescription: "bar", date: Date(timeIntervalSince1970: 0))
                    try? realm.write {
                        realm.add(RealmTask.from(task: task))
                    }
                }

                it("should remove value") {
                    let expected: [Recorded<Event<[Task]>>] = [
                        .next(0, [
                            Task(id: "1", title: "foo", taskDescription: "bar", date: Date(timeIntervalSince1970: 0))
                        ]),
                        .next(10, [])
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }

            context("when storage doesn't contain deleting value") {
                beforeEach {
                    let realm = try! Realm()
                    let task = Task(id: "2", title: "foo", taskDescription: "bar", date: Date(timeIntervalSince1970: 0))
                    try? realm.write {
                        realm.add(RealmTask.from(task: task))
                    }
                }

                it("should remain the same") {
                    let expected: [Recorded<Event<[Task]>>] = [
                        .next(0, [
                            Task(id: "2", title: "foo", taskDescription: "bar", date: Date(timeIntervalSince1970: 0))
                        ]),
                        .next(10, [
                            Task(id: "2", title: "foo", taskDescription: "bar", date: Date(timeIntervalSince1970: 0))
                        ])
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }
        }
    }
}
