//
//  RootInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 6/20/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum RootInteractorError: Error {
    case failed
}

public protocol RootInteractor {
    func isUserAuthorized() -> Single<Bool>
    func requestPushNotificationPermissions() -> Single<Bool>
}

public final class RootInteractorImpl {
    private let authorizationService: AuthorizationService
    private let pushNotificationsService: PushNotificationsService
    
    public init(
        authorizationService: AuthorizationService,
        pushNotificationsService: PushNotificationsService
    ) {
        self.authorizationService = authorizationService
        self.pushNotificationsService = pushNotificationsService
    }
}

// MARK: - RootInteractor implementation

extension RootInteractorImpl: RootInteractor {
    public func isUserAuthorized() -> Single<Bool> {
        return authorizationService.isAuthorized()
            .catchError { _ in .error(RootInteractorError.failed) }
    }

    public func requestPushNotificationPermissions() -> Single<Bool> {
        return pushNotificationsService.requestPermissions()
            .catchError { _ in .error(RootInteractorError.failed) }
    }
}
