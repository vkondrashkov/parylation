//
// 
//  TaskEditViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import RxCocoa
import RxSwift
import ParylationDomain

final class TaskEditViewModelImpl: TaskEditViewModel {
    private let interactor: TaskEditInteractor
    private let router: TaskEditRouter
    private let taskId: String?

    private var taskTitleValue = ""
    private var taskDescriptionValue = ""
    private var taskDateValue = Date()

    let willAppearTrigger: AnyObserver<Void>
    let taskTitle: AnyObserver<String>
    let taskDescription: AnyObserver<String>
    let taskDate: AnyObserver<Date>
    let saveTrigger: AnyObserver<Void>

    let state: Driver<TaskEditViewState>

    private let disposeBag = DisposeBag()

    init(
        interactor: TaskEditInteractor,
        router: TaskEditRouter,
        taskId: String? = nil
    ) {
        self.interactor = interactor
        self.router = router
        self.taskId = taskId

        let titleSubject = PublishSubject<String>()
        let descriptionSubject = PublishSubject<String>()
        let dateSubject = PublishSubject<Date>()

        let stateSubject = BehaviorSubject<TaskEditViewState>(value: .ready)
        stateSubject
            .subscribe(onNext: { state_ in
                if case .display(let info) = state_ {
                    titleSubject.onNext(info.title)
                    descriptionSubject.onNext(info.taskDescription)
                    dateSubject.onNext(info.date)
                }
            })
            .disposed(by: disposeBag)

        let willAppearSubject = PublishSubject<Void>()
        willAppearSubject
            .do(onNext: { stateSubject.onNext(.loading) })
            .flatMap { interactor.fetchTask(taskId: taskId ?? "")}
            .map { TaskEditViewInfo.from(task: $0) }
            .map { TaskEditViewState.display($0) }
            .bind(to: stateSubject)
            .disposed(by: disposeBag)

        let title = titleSubject
            .distinctUntilChanged()
        let titleValidation = title
            .flatMap { interactor.validate(title: $0) }

        let description = descriptionSubject
            .distinctUntilChanged()
        let descriptionValidation = description
            .flatMap { interactor.validate(description: $0)}

        let date = dateSubject
            .distinctUntilChanged()

        let taskData = Observable
            .combineLatest(title, description, date)
        let validation = Observable
            .combineLatest(titleValidation, descriptionValidation)
        let saveSubject = PublishSubject<Void>()
        let task = saveSubject
            .withLatestFrom(validation)
            .filter { $0 && $1 }
            .map { _ in () }
            .do(onNext: { stateSubject.onNext(.loading) })
            .withLatestFrom(taskData)
            .map { Task(
                id: taskId ?? UUID().uuidString,
                title: $0,
                taskDescription: $1,
                date: $2
            )}

        task
            .flatMap { interactor.save(task: $0) }
            .withLatestFrom(task)
            .map {
                return PushNotification(
                    id: $0.id,
                    title: $0.title,
                    body: $0.taskDescription,
                    date: $0.date,
                    badge: 1
                )
            }
            .flatMap { interactor.scheduleNotification($0) }
            .observeOn(MainScheduler.instance)
            .subscribe { _ in router.terminate() }
            .disposed(by: disposeBag)

        willAppearTrigger = willAppearSubject.asObserver()
        taskTitle = titleSubject.asObserver()
        taskDescription = descriptionSubject.asObserver()
        taskDate = dateSubject.asObserver()
        saveTrigger = saveSubject.asObserver()

        state = stateSubject
            .asDriver(onErrorJustReturn: .ready)
    }
}
