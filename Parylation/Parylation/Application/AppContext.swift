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
import Moya

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
    let userService: UserService
    let taskRepository: TaskRepository
    let iconRepository: IconRepository
    let colorRepository: ColorRepository
    let pushNotificationsService: PushNotificationsService

    init(window: UIWindow)  {
        self.window = window
        let realm = try! Realm()

        let userProvider = MoyaProvider<UserAPI>(stubClosure: MoyaProvider<UserAPI>.immediatelyStub)
        let userRepository = UserRepositoryImpl(provider: userProvider)
        let authorizedUserRepository = AuthorizedUserRepositoryImpl(realm: realm)
        authorizationService = AuthorizationServiceImpl(
            userRepository: userRepository,
            authorizedUserRepository: authorizedUserRepository
        )
        userService = UserServiceImpl(
            userRepository: userRepository,
            authorizedUserRepository: authorizedUserRepository
        )
        taskRepository = TaskRepositoryImpl(realm: realm)
        iconRepository = IconRepositoryImpl()
        colorRepository = ColorRepositoryImpl()
        pushNotificationsService = PushNotificationsServiceImpl()
    }
}
