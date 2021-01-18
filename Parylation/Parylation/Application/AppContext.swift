//
//  AppContext.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 9/2/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import ParylationDomain
import RealmSwift
import UIKit

// TODO: typealias AnalyticsContext =

typealias AuthContext = RootContainer
    & WelcomeContainer
    & SignUpContainer
    & SignInContainer

typealias HomeContext = DashboardContainer
    & HomeContainer
    & TaskContainer
    & TaskEditContainer

// TODO: typealias CalendarContext

typealias SettingsContext = SettingsContainer

typealias MainContext = HomeContext
    & SettingsContext

typealias AppContext = AuthContext & MainContext // & AnalyticsContext

final class AppContextImpl: AppContext {
    unowned var window: UIWindow
    let authorizationService: AuthorizationService
    let taskRepository: TaskRepository
    let pushNotificationsUseCase: PushNotificationsUseCase

    init(window: UIWindow)  {
        self.window = window
        let realm = try! Realm()
        let authorizedUserRepository = AuthorizedUserRepositoryImpl(realm: realm)
        authorizationService = AuthorizationServiceImpl(
            authorizedUserRepository: authorizedUserRepository
        )
        taskRepository = TaskRepositoryImpl(realm: realm)
        pushNotificationsUseCase = PushNotificationsUseCaseImpl()
    }
}
