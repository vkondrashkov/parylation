//
//  RootViewModelSpec.swift
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

final class RootViewModelSpec: QuickSpec {
    override func spec() {
        var scheduler: TestScheduler!
        var viewModel: RootViewModel!
        var interactorMock: RootInteractorMock!
        var routerSpy: RootRouterSpy!
        var disposeBag: DisposeBag!

        beforeEach {
            scheduler = TestScheduler(initialClock: 0)
            interactorMock = RootInteractorMock()
            routerSpy = RootRouterSpy()
            viewModel = RootViewModelImpl(
                interactor: interactorMock,
                router: routerSpy
            )
            disposeBag = DisposeBag()
        }

        describe("on didAppear") {
            beforeEach {
                scheduler
                    .createColdObservable([
                        .next(0, ())
                    ])
                    .bind(to: viewModel.viewDidAppearTrigger)
                    .disposed(by: disposeBag)
            }
            
            context("when user is authorized") {
                beforeEach {
                    interactorMock.isUserAuthorizedResponse = { .just(true) }
                }

                it("should show dashboard") {
                    scheduler.start()
                    expect(routerSpy.showDashboardInvoked).to(beTrue())
                }

                it("shouldn't show welcome") {
                    scheduler.start()
                    expect(routerSpy.showWelcomeInvoked).to(beFalse())
                }
            }

            context("when user is not authorized") {
                beforeEach {
                    interactorMock.isUserAuthorizedResponse = { .just(false) }
                }

                it("should show welcome") {
                    scheduler.start()
                    expect(routerSpy.showWelcomeInvoked).to(beTrue())
                }

                it("shouldn't show dashboard") {
                    scheduler.start()
                    expect(routerSpy.showDashboardInvoked).to(beFalse())
                }
            }

            it("should request notification permission") {
                scheduler.start()
                expect(interactorMock.requestPushNotificationPermissionsInvoked).to(beTrue())
            }
        }
    }
}
