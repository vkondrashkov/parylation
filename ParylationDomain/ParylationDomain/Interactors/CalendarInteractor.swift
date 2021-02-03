//
//  CalendarInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 27.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum CalendarInteractorError: Error {
    case failed
}

public protocol CalendarInteractor {
    func monthMetadata(date: Date) -> Single<MonthMetadata>
}

public final class CalendarInteractorImpl {
    private let calendar: Calendar

    public init(
        calendar: Calendar
    ) {
        self.calendar = calendar
    }
}

// MARK: - CalendarInteractor implementation

extension CalendarInteractorImpl: CalendarInteractor {
    public func monthMetadata(date: Date) -> Single<MonthMetadata> {
        return .create { [weak self] single in
            guard let self = self else {
                single(.error(CalendarInteractorError.failed))
                return Disposables.create()
            }
            let numberOfDaysInMonth = self.calendar.range(of: .day, in: .month, for: date)?.count
            let firstDayOfMonth = self.calendar.date(from: self.calendar.dateComponents([.year, .month], from: date))

            guard let numberOfDays = numberOfDaysInMonth, let firstDay = firstDayOfMonth else {
                single(.error(CalendarInteractorError.failed))
                return Disposables.create()
            }

            let lastDayInMonth = self.calendar.date(byAdding: DateComponents(month: 1, day: -1), to: firstDay)
            let firstDayWeekday = self.calendar.component(.weekday, from: firstDay)

            guard let lastDay = lastDayInMonth else {
                single(.error(CalendarInteractorError.failed))
                return Disposables.create()
            }

            let metadata = MonthMetadata(
                numberOfDays: numberOfDays,
                firstDay: firstDay,
                lastDay: lastDay,
                firstDayWeekday: firstDayWeekday
            )
            single(.success(metadata))
            return Disposables.create()
        }
    }
}

