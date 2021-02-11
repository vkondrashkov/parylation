//
// 
//  DayViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 10.02.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//
//

import RxCocoa
import RxSwift
import ParylationDomain

final class DayViewModelImpl: DayViewModel {
    private let interactor: DayInteractor
    private let router: DayRouter

    let reloadTrigger: AnyObserver<Void>
    let createTrigger: AnyObserver<Void>
    let selectTrigger: AnyObserver<IndexPath>

    let items: Driver<[DayTableItem]>
    let selectedDay: Driver<String>

    private let disposeBag = DisposeBag()

    init(
        interactor: DayInteractor,
        router: DayRouter,
        date: Date
    ) {
        self.interactor = interactor
        self.router = router

        let reloadSubject = PublishSubject<Void>()
        let tasks = reloadSubject
            .flatMap { interactor.fetchTaks() }

        let tasksSequence = tasks
            .take(1)
            .flatMap { Observable.from($0) }

        let colors = tasksSequence
            .flatMap { interactor.fetchColor(id: $0.colorId) }

        let icons = tasksSequence
            .flatMap { interactor.fetchIcon(id: $0.iconId) }

        let taskItems = Observable.zip(tasksSequence, colors, icons)
            .share()
            .map { task, color, icon in
                DayTableItem(
                    id: task.id,
                    icon: icon.image,
                    color: color.value,
                    title: task.title
                )
            }
            .debug("🛑 Item")
            .toArray()
            .debug("🛑 Array")

        let createSubject = PublishSubject<Void>()

        let selectSubject = PublishSubject<IndexPath>()
        selectSubject
            .withLatestFrom(tasks) { ($0, $1) }
            .compactMap { indexPath, items -> Task? in
                guard items.count > indexPath.row else {
                    return nil
                }
                return items[indexPath.row]
            }
            .subscribe(onNext: { task in
                router.showTask(taskId: task.id)
            })
            .disposed(by: disposeBag)

        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "dd MMMM y"
        let day = Observable.just(monthFormatter.string(from: date))

        reloadTrigger = reloadSubject.asObserver()
        createTrigger = createSubject.asObserver()
        selectTrigger = selectSubject.asObserver()

        items = taskItems
            .asDriver(onErrorJustReturn: [])

        selectedDay = day
            .asDriver(onErrorJustReturn: "")
    }
}
