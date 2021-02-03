//
//  MonthMetadata.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 31.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

public struct MonthMetadata {
    public let numberOfDays: Int
    public let firstDay: Date
    public let lastDay: Date
    public let firstDayWeekday: Int

    public init(
        numberOfDays: Int,
        firstDay: Date,
        lastDay: Date,
        firstDayWeekday: Int
    ) {
        self.numberOfDays = numberOfDays
        self.firstDay = firstDay
        self.lastDay = lastDay
        self.firstDayWeekday = firstDayWeekday
    }
}
