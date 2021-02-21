//
// 
//  CalendarContract.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 27.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//
//

import UIKit
import RxCocoa
import RxSwift

protocol CalendarContainer { }

protocol CalendarBuilder {
    func build() -> UIViewController
}

protocol CalendarRouter: AnyObject {
    func showTaskCreation(data: TaskEditData)
    func showDay(date: Date)
}

protocol CalendarViewModel {
    var daySelectionTrigger: AnyObserver<Date> { get }
    var previousMonthTrigger: AnyObserver<Void> { get }
    var nextMonthTrigger: AnyObserver<Void> { get }
    var selectTrigger: AnyObserver<IndexPath> { get }
    var createTrigger: AnyObserver<Void> { get }

    var numberOfWeeks: Driver<Int> { get }
    var selectedMonth: Driver<String> { get }
    var weekDays: Driver<[String]> { get }
    var days: Driver<[Day]> { get }
}
