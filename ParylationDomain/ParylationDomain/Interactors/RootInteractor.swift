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
    private let authorizationUseCase: AuthorizationUseCase
    private let pushNotificationsUseCase: PushNotificationsUseCase
    
    public init(
        authorizationUseCase: AuthorizationUseCase,
        pushNotificationsUseCase: PushNotificationsUseCase
    ) {
        self.authorizationUseCase = authorizationUseCase
        self.pushNotificationsUseCase = pushNotificationsUseCase
    }
}

// MARK: - RootInteractor implementation

extension RootInteractorImpl: RootInteractor {
    public func isUserAuthorized() -> Single<Bool> {
        return authorizationUseCase.isAuthorized()
            .catchError { _ in .error(RootInteractorError.failed) }
    }

    public func requestPushNotificationPermissions() -> Single<Bool> {
        return pushNotificationsUseCase.requestPermissions()
            .catchError { _ in .error(RootInteractorError.failed) }
    }
}
