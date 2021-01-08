//
//  PushNotification.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 5.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

public struct PushNotification {
    let id: String
    let title: String
    let body: String
    let date: Date
    let badge: Int

    public init(
        id: String,
        title: String,
        body: String,
        date: Date,
        badge: Int
    ) {
        self.id = id
        self.title = title
        self.body = body
        self.date = date
        self.badge = badge
    }
}
