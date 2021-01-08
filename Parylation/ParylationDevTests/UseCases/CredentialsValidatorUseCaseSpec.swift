//
//  CredentialsValidatorUseCaseSpec.swift
//  ParylationDevTests
//
//  Created by Vladislav Kondrashkov on 7.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift
import RxTest
import ParylationDomain
import Quick
import Nimble

@testable import ParylationDev

final class CredentialsValidatorUseCaseSpec: QuickSpec {
    override func spec() {
        var credentialsValidatorUseCase: CredentialsValidatorUseCase!
        var scheduler: TestScheduler!
        var disposeBag: DisposeBag!

        beforeEach {
            credentialsValidatorUseCase = CredentialsValidatorUseCaseImpl()
            scheduler = TestScheduler(initialClock: 0)
            disposeBag = DisposeBag()
        }

        describe("on validate(email:)") {
            var inputSubject: PublishSubject<String>!
            var observer: TestableObserver<Bool>!

            beforeEach {
                observer = scheduler.createObserver(Bool.self)
                inputSubject = PublishSubject()
                inputSubject
                    .flatMap { credentialsValidatorUseCase.validate(email: $0) }
                    .asObservable()
                    .bind(to: observer)
                    .disposed(by: disposeBag)
            }

            context("when existing email given") {
                it("should return true") {
                    scheduler
                        .createColdObservable([
                            .next(10, "example@domain.com")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, true)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }

            context("when invalid email given") {
                it("should return false") {
                    scheduler
                        .createColdObservable([
                            .next(10, "exampledomain.com")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, false)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }

            context("when short email given") {
                it("should return false") {
                    scheduler
                        .createColdObservable([
                            .next(10, "e@d.c")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, false)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }

            context("when long email given") {
                it("should return false") {
                    scheduler
                        .createColdObservable([
                            .next(10, "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, false)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }
        }

        describe("on validate(username:)") {
            var inputSubject: PublishSubject<String>!
            var observer: TestableObserver<Bool>!

            beforeEach {
                observer = scheduler.createObserver(Bool.self)
                inputSubject = PublishSubject()
                inputSubject
                    .flatMap { credentialsValidatorUseCase.validate(username: $0) }
                    .asObservable()
                    .bind(to: observer)
                    .disposed(by: disposeBag)
            }

            context("when valid username given") {
                it("should return true") {
                    scheduler
                        .createColdObservable([
                            .next(10, "vkondrashkov")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, true)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }

            context("when system username given") {
                it("should return false") {
                    scheduler
                        .createColdObservable([
                            .next(10, "user123")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, false)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }

            context("when short username given") {
                it("should return false") {
                    scheduler
                        .createColdObservable([
                            .next(10, "us")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, false)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }

            context("when long username given") {
                it("should return false") {
                    scheduler
                        .createColdObservable([
                            .next(10, "usernameWhichContainsTooSymbolsThatAreNotFitString")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, false)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }

            context("when username with special characters given") {
                it("should return false") {
                    scheduler
                        .createColdObservable([
                            .next(10, "d3cl!p$")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, false)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }
        }

        describe("on validate(password:)") {
            var inputSubject: PublishSubject<String>!
            var observer: TestableObserver<Bool>!

            beforeEach {
                observer = scheduler.createObserver(Bool.self)
                inputSubject = PublishSubject()
                inputSubject
                    .flatMap { credentialsValidatorUseCase.validate(password: $0) }
                    .asObservable()
                    .bind(to: observer)
                    .disposed(by: disposeBag)
            }

            context("when valid password given") {
                it("should return true") {
                    scheduler
                        .createColdObservable([
                            .next(10, "fooBar123456")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, true)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }

            context("when short password given") {
                it("should return false") {
                    scheduler
                        .createColdObservable([
                            .next(10, "foo")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, false)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }

            context("when long password given") {
                it("should return false") {
                    scheduler
                        .createColdObservable([
                            .next(10, "thisIsToo123LongPassword123AndShouldntBeValid")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, false)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }

            context("when password with only symbols given") {
                it("should return false") {
                    scheduler
                        .createColdObservable([
                            .next(10, "onlySymbolPass")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, false)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }

            context("when password with only digits given") {
                it("should return false") {
                    scheduler
                        .createColdObservable([
                            .next(10, "123456789")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, false)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }

            context("when password with special characters given") {
                it("should return true") {
                    scheduler
                        .createColdObservable([
                            .next(10, "this$#@123Pass")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, true)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }
        }

        describe("on validate(taskTitle:)") {
            var inputSubject: PublishSubject<String>!
            var observer: TestableObserver<Bool>!

            beforeEach {
                observer = scheduler.createObserver(Bool.self)
                inputSubject = PublishSubject()
                inputSubject
                    .flatMap { credentialsValidatorUseCase.validate(taskTitle: $0) }
                    .asObservable()
                    .bind(to: observer)
                    .disposed(by: disposeBag)
            }

            context("when regular title given") {
                it("should return true") {
                    scheduler
                        .createColdObservable([
                            .next(10, "Do tests")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, true)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }

            context("when empty title given") {
                it("should return false") {
                    scheduler
                        .createColdObservable([
                            .next(10, "")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, false)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }

            context("when whitespaced title given") {
                it("should return false") {
                    scheduler
                        .createColdObservable([
                            .next(10, " \n")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, false)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }
        }

        describe("on validate(taskDescription:)") {
            var inputSubject: PublishSubject<String>!
            var observer: TestableObserver<Bool>!

            beforeEach {
                observer = scheduler.createObserver(Bool.self)
                inputSubject = PublishSubject()
                inputSubject
                    .flatMap { credentialsValidatorUseCase.validate(taskDescription: $0) }
                    .asObservable()
                    .bind(to: observer)
                    .disposed(by: disposeBag)
            }

            context("when regular title given") {
                it("should return true") {
                    scheduler
                        .createColdObservable([
                            .next(10, "Do tests")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, true)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }

            context("when empty title given") {
                it("should return false") {
                    scheduler
                        .createColdObservable([
                            .next(10, "")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, false)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }

            context("when whitespaced title given") {
                it("should return false") {
                    scheduler
                        .createColdObservable([
                            .next(10, " \n")
                        ])
                        .bind(to: inputSubject)
                        .disposed(by: disposeBag)

                    let expected: [Recorded<Event<Bool>>] = [
                        .next(10, false)
                    ]

                    scheduler.start()
                    expect(observer.events).to(equal(expected))
                }
            }
        }
    }
}
