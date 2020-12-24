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

typealias MainContext = DashboardContainer
    & HomeContainer
    & SettingsContainer

typealias AppContext = AuthContext & MainContext // & AnalyticsContext

final class AppContextImpl: AppContext {
    unowned var window: UIWindow
    let authorizationUseCase: AuthorizationUseCase
    let taskRepository: TaskRepository

    init(window: UIWindow)  {
        self.window = window
        let realm = try! Realm()
        let authorizedUserRepository = AuthorizedUserRepositoryImpl(realm: realm)
        authorizationUseCase = AuthorizationUseCaseImpl(
            authorizedUserRepository: authorizedUserRepository
        )
        taskRepository = TaskRepositoryImpl(realm: realm)
    }
}
