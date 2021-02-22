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
    let willDisplayItemTrigger: AnyObserver<IndexPath>
    let selectTrigger: AnyObserver<IndexPath>
    let deleteTrigger: AnyObserver<IndexPath>

    let itemIcon: Driver<(Icon, IndexPath)>
    let itemColor: Driver<(ParylationDomain.Color, IndexPath)>
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

        let sections_ = tasks
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
            .subscribe(onNext: {
                router.showTaskCreation()
            })
            .disposed(by: disposeBag)

        let willDisplayItemSubject = PublishSubject<IndexPath>()
        let willDisplayItem = willDisplayItemSubject
            .withLatestFrom(tasks) { ($0, $1) }
            .compactMap { indexPath_, tasks_ -> (Task, IndexPath)? in
                guard tasks_.count > indexPath_.row else {
                    return nil
                }
                return (tasks_[indexPath_.row], indexPath_)
            }

        let icon = willDisplayItem
            .flatMap { task, indexPath in interactor.fetchIcon(id: task.iconId).map { ($0, indexPath) } }

        let color = willDisplayItem
            .flatMap { task, indexPath in interactor.fetchColor(id: task.colorId).map { ($0, indexPath) } }

        let selectSubject = PublishSubject<IndexPath>()
        selectSubject
            .withLatestFrom(sections_) { ($0, $1) }
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
            .withLatestFrom(sections_) { ($0, $1) }
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
        willDisplayItemTrigger = willDisplayItemSubject.asObserver()
        selectTrigger = selectSubject.asObserver()
        deleteTrigger = deleteSubject.asObserver()

        itemIcon = icon.asDriver(onErrorJustReturn: (Icon(id: "", image: UIImage()), IndexPath()))
        itemColor = color.asDriver(onErrorJustReturn: (ParylationDomain.Color(id: "", value: .clear), IndexPath()))
        sections = sections_.asDriver(onErrorJustReturn: [])
    }
}
