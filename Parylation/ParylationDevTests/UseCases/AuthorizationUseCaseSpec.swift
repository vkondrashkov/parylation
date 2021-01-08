//
//  AuthorizationUseCaseSpec.swift
//  ParylationDevTests
//
//  Created by Vladislav Kondrashkov on 6/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RealmSwift
import RxSwift
import RxTest
import ParylationDomain
import Quick
import Nimble

@testable import ParylationDev

final class AuthorizationUseCaseSpec: QuickSpec {
    override func spec() {
        var scheduler: TestScheduler!
        var authorizationUseCase: AuthorizationUseCase!
        var disposeBag: DisposeBag!
        
        beforeSuite {
            Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        }

        beforeEach {
            scheduler = TestScheduler(initialClock: 0)
            authorizationUseCase = AuthorizationUseCaseImpl(
                authorizedUserRepository: AuthorizedUserRepositoryImpl(realm: try! Realm())
            )
            disposeBag = DisposeBag()
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
        }
        
        context("when user is authorized") {
            beforeEach {
                let realm = try! Realm()
                try! realm.write {
                    let user = User(id: "foo", name: "bar")
                    realm.add(RealmUser.from(user: user))
                }
            }
            
            describe("on isAuthorized()") {
                it("should return true") {
                    let observer = scheduler.createObserver(Bool.self)
                    authorizationUseCase.isAuthorized()
                        .asObservable()
                        .bind(to: observer)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(0, true),
                        .completed(0)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }
            
            describe("on fetchUser()") {
                it("should return user") {
                    let observer = scheduler.createObserver(User.self)
                    authorizationUseCase.fetchCurrentUser()
                        .asObservable()
                        .bind(to: observer)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<User>>] = [
                        .next(0, User(id: "foo", name: "bar")),
                        .completed(0)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }
        }
        
        context("when user is not authorized") {
            describe("on isAuthorized()") {
                it("should return false") {
                    let observer = scheduler.createObserver(Bool.self)
                    authorizationUseCase.isAuthorized()
                        .asObservable()
                        .bind(to: observer)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(0, false),
                        .completed(0)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }
            
            describe("on fetchUser()") {
                it("should return error") {
                    let observer = scheduler.createObserver(User.self)
                    authorizationUseCase.fetchCurrentUser()
                        .asObservable()
                        .bind(to: observer)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<User>>] = [
                        .error(0, AuthorizationUseCaseError.missingData)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }
        }
    }
}
