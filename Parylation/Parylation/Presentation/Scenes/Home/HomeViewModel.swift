//
//  HomeViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxCocoa
import RxSwift
import ParylationDomain

final class HomeViewModelImpl: HomeViewModel {
    private let interactor: HomeInteractor
    private let router: HomeRouter

    let reloadTrigger: AnyObserver<Void>
    let createTrigger: AnyObserver<Void>
    let selectTrigger: AnyObserver<IndexPath>
    let deleteTrigger: AnyObserver<IndexPath>

    let sections: Driver<[HomeTableSection]>
    
    private let disposeBag = DisposeBag()
    
    init(
        interactor: HomeInteractor,
        router: HomeRouter
    ) {
        self.interactor = interactor
        self.router = router

        let reloadSubject = PublishSubject<Void>()
        let tasks = reloadSubject
            .flatMap { _ in interactor.fetchTaks() }
            .map {
                $0.map { HomeTableItem(
                    id: $0.id,
                    icon: nil,
                    color: Color.gigas,
                    title: $0.title
                ) }
            }
            .map { [HomeTableSection(name: "Upcoming tasks", items: $0)] }

        let createSubject = PublishSubject<Void>()
        createSubject
            .flatMap { _ in interactor.createTask(task: Task(id: "", title: "Foo", taskDescription: "Bar", date: Date()))}
            .bind(to: reloadSubject)
            .disposed(by: disposeBag)

        let selectSubject = PublishSubject<IndexPath>()
        selectSubject
            .withLatestFrom(tasks) { ($0, $1) }
            .compactMap { indexPath, sections -> HomeTableItem? in
                guard sections.count > indexPath.section else {
                    return nil
                }
                let items = sections[indexPath.section].items
                guard items.count > indexPath.row else {
                    return nil
                }
                return items[indexPath.row]
            }
            .subscribe(onNext: { task in
                router.showTask(taskId: task.id)
            })
            .disposed(by: disposeBag)

        let deleteSubject = PublishSubject<IndexPath>()
        deleteSubject
            .withLatestFrom(tasks) { ($0, $1) }
            .compactMap { indexPath, sections -> HomeTableItem? in
                guard sections.count > indexPath.section else {
                    return nil
                }
                let items = sections[indexPath.section].items
                guard items.count > indexPath.row else {
                    return nil
                }
                return items[indexPath.row]
            }
            .flatMap { interactor.deleteTask(taskId: $0.id) }
            .bind(to: reloadSubject)
            .disposed(by: disposeBag)

        reloadTrigger = reloadSubject.asObserver()
        createTrigger = createSubject.asObserver()
        selectTrigger = selectSubject.asObserver()
        deleteTrigger = deleteSubject.asObserver()

        sections = tasks.asDriver(onErrorJustReturn: [])
    }
}
