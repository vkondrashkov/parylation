//
// 
//  CalendarViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 27.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//
//

import RxCocoa
import RxSwift
import ParylationDomain

final class CalendarViewModelImpl: CalendarViewModel {
    private let interactor: CalendarInteractor
    private let router: CalendarRouter
    private let calendar: Calendar
    private let dateFormatter: DateFormatter

    private let selectedDaySubject = PublishSubject<Date>()
    private let daysSubject = PublishSubject<[Day]>()

    let daySelectionTrigger: AnyObserver<Date>
    let previousMonthTrigger: AnyObserver<Void>
    let nextMonthTrigger: AnyObserver<Void>
    let selectTrigger: AnyObserver<IndexPath>
    let createTrigger: AnyObserver<Void>

    let numberOfWeeks: Driver<Int>
    let selectedMonth: Driver<String>
    let weekDays: Driver<[String]>
    let days: Driver<[Day]>

    private let disposeBag = DisposeBag()

    init(
        interactor: CalendarInteractor,
        router: CalendarRouter,
        calendar: Calendar,
        dateFormatter: DateFormatter
    ) {
        self.interactor = interactor
        self.router = router
        self.calendar = calendar
        self.dateFormatter = dateFormatter

        let numberOfWeeks_ = selectedDaySubject
            .map { calendar.range(of: .weekOfMonth, in: .month, for: $0)?.count ?? 0 }

        let currentMonth = selectedDaySubject
            .map { date -> String in
                let monthFormatter = DateFormatter()
                monthFormatter.dateFormat = "MMMM y"
                return monthFormatter.string(from: date)
            }

        let weekDays_ = daysSubject
            .map { $0.suffix(7) }
            .map { days_ -> [String] in
                let weekdayFormatter = DateFormatter()
                weekdayFormatter.dateFormat = "EEE"
                return days_.map {
                    weekdayFormatter.string(from: $0.date)
                }
            }

        let previousMonthSubject = PublishSubject<Void>()
        previousMonthSubject
            .withLatestFrom(selectedDaySubject)
            .compactMap { calendar.date(byAdding: DateComponents(month: -1), to: $0) }
            .bind(to: selectedDaySubject)
            .disposed(by: disposeBag)

        let nextMonthSubject = PublishSubject<Void>()
        nextMonthSubject
            .withLatestFrom(selectedDaySubject)
            .compactMap { calendar.date(byAdding: DateComponents(month: 1), to: $0) }
            .bind(to: selectedDaySubject)
            .disposed(by: disposeBag)

        let selectSubject = PublishSubject<IndexPath>()
        selectSubject
            .withLatestFrom(daysSubject) { ($0, $1) }
            .map { $1[$0.row].date }
            .bind(to: selectedDaySubject)
            .disposed(by: disposeBag)

        let createSubject = PublishSubject<Void>()
        createSubject
            .withLatestFrom(selectedDaySubject)
            .subscribe(onNext: { date in
                let taskEditData = TaskEditData(date: date)
                router.showTaskCreation(data: taskEditData)
            })
            .disposed(by: disposeBag)

        daySelectionTrigger = selectedDaySubject.asObserver()
        previousMonthTrigger = previousMonthSubject.asObserver()
        nextMonthTrigger = nextMonthSubject.asObserver()
        selectTrigger = selectSubject.asObserver()
        createTrigger = createSubject.asObserver()

        numberOfWeeks = numberOfWeeks_
            .asDriver(onErrorJustReturn: 0)
        selectedMonth = currentMonth
            .asDriver(onErrorJustReturn: "")
        weekDays = weekDays_
            .asDriver(onErrorJustReturn: [])
        days = daysSubject
            .asDriver(onErrorJustReturn: [])

        finishViewModelSetup()
    }

    private func finishViewModelSetup() {
        selectedDaySubject
            .distinctUntilChanged()
            .flatMap { self.interactor.monthMetadata(date: $0) }
            .withLatestFrom(selectedDaySubject) { ($0, $1) }
            .map { self.generateDaysInMonth(metadata: $0, selectedDate: $1) }
            .bind(to: daysSubject)
            .disposed(by: disposeBag)

        let sameDay = selectedDaySubject
            .scan([]) { previous, current in
                return Array(previous + [current]).suffix(2)
            }
            .filter { $0.count > 1 }
            .filter { $0[0] == $0[1] }
            .compactMap { $0.first }

        sameDay
            .subscribe(onNext: { [weak self] date in
                self?.router.showDay(date: date)
            })
            .disposed(by: disposeBag)
    }

    private func generateDaysInMonth(metadata: MonthMetadata, selectedDate: Date) -> [Day] {
        let numberOfDaysInMonth = metadata.numberOfDays
        let offsetInInitialRow = metadata.firstDayWeekday
        let firstDayOfMonth = metadata.firstDay

        var days: [Day] = (1..<(numberOfDaysInMonth + offsetInInitialRow))
            .map { day in
                let isWithinDisplayedMonth = day >= offsetInInitialRow
                let dayOffset =
                    isWithinDisplayedMonth ?
                    day - offsetInInitialRow :
                    -(offsetInInitialRow - day)
                return generateDay(
                    dayOffset: dayOffset,
                    baseDate: firstDayOfMonth,
                    isWithinDisplayedMonth: isWithinDisplayedMonth,
                    selectedDate: selectedDate
                )
            }
        days += generateStartOfNextMonth(
            firstDayOfDisplayedMonth: firstDayOfMonth,
            selectedDate: selectedDate
        )
        return days
    }

    func generateStartOfNextMonth(
        firstDayOfDisplayedMonth: Date,
        selectedDate: Date
    ) -> [Day] {
        guard
            let lastDayInMonth = calendar.date(
                byAdding: DateComponents(month: 1, day: -1),
                to: firstDayOfDisplayedMonth
            )
        else {
            return []
        }

        let additionalDays = 7 - calendar.component(.weekday, from: lastDayInMonth)
        guard additionalDays > 0 else {
            return []
        }

        let days: [Day] = (1...additionalDays)
            .map {
                generateDay(
                    dayOffset: $0,
                    baseDate: lastDayInMonth,
                    isWithinDisplayedMonth: false,
                    selectedDate: selectedDate
                )
            }

        return days
    }

    func generateDay(
        dayOffset: Int,
        baseDate: Date,
        isWithinDisplayedMonth: Bool,
        selectedDate: Date
    ) -> Day {
        let date = calendar.date(
            byAdding: .day,
            value: dayOffset,
            to: baseDate
        ) ?? baseDate
        return Day(
            date: date,
            number: dateFormatter.string(from: date),
            isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
            isWithinDisplayedMonth: isWithinDisplayedMonth
        )
    }
}
