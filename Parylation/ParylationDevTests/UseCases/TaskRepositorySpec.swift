//
//  TaskRepositorySpec.swift
//  ParylationDevTests
//
//  Created by Vladislav Kondrashkov on 24.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RealmSwift
import RxSwift
import ParylationDomain
import Quick
import Nimble

@testable import ParylationDev

final class TaskRepositorySpec: QuickSpec {
    override func spec() {
        var taskRepository: TaskRepository!

        beforeSuite {
            Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        }

        beforeEach {
            let realm = try! Realm()
            try? realm.write {
                realm.deleteAll()
            }
            taskRepository = TaskRepositoryImpl(realm: realm)
        }

        describe("on fetchTasks()") {
            context("when storage is not empty") {
                beforeEach {
                    let realm = try! Realm()
                    let task = Task(id: "", title: "foo", taskDescription: "bar", date: Date())
                    try? realm.write {
                        realm.add(RealmTask.from(task: task))
                    }
                }

                it("should contain value") {

                }
            }

            context("when storage is empty") {
                it("shouldn't contain value") {

                }
            }
        }

        describe("on save(:)") {
            context("when storage is empty") {
                it("should store value") {

                }
            }

            context("when storage has values") {
                it("should store value") {

                }
            }

            context("when storage has same values") {
                it("shouldn't store value") {
                    // TODO: Discuss
                }
            }
        }

        describe("on deleteTask(:)") {
            context("when storage contains deleting value") {
                it("should remove value") {

                }
            }

            context("when storage doesn't contain deleting value") {
                it("should remain the same") {

                }
            }
        }
    }
}
