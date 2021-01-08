//
//  RootInteractorMock.swift
//  ParylationDevTests
//
//  Created by Vladislav Kondrashkov on 7.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift
import ParylationDomain

enum MockError: Error {
    case missingStub
}

final class RootInteractorMock: RootInteractor {
    var isUserAuthorizedInvoked = false
    var requestPushNotificationPermissionsInvoked = false

    var isUserAuthorizedResponse: (() -> Single<Bool>)?
    var requestPushNotificationPermissionsResponse: (() -> Single<Bool>)?

    func isUserAuthorized() -> Single<Bool> {
        isUserAuthorizedInvoked = true
        return isUserAuthorizedResponse?() ?? .error(MockError.missingStub)
    }

    func requestPushNotificationPermissions() -> Single<Bool> {
        requestPushNotificationPermissionsInvoked = true
        return requestPushNotificationPermissionsResponse?() ?? .error(MockError.missingStub)
    }
}
