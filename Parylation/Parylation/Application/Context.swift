//
//  Context.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 9/2/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

// TODO: typealias AnalyticsContext =

typealias AuthContext = RootContainer
    & WelcomeContainer
    & SignUpContainer
    & SignInContainer

typealias MainContext = DashboardContainer
    & HomeContainer
    & SettingsContainer

typealias AppContext = AuthContext & MainContext // & AnalyticsContext
