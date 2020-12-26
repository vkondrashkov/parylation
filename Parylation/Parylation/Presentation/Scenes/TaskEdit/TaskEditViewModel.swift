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

    private let willAppearSubject = PublishSubject<Void>()
    private let titleSubject = PublishSubject<String>()
    private let descriptionSubject = PublishSubject<String>()
    private let dateSubject = PublishSubject<Date>()
    private let saveSubject = PublishSubject<Void>()
    private let stateSubject = BehaviorSubject<TaskEditViewState>(value: .ready)

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

        willAppearTrigger = willAppearSubject.asObserver()
        taskTitle = titleSubject.asObserver()
        taskDescription = descriptionSubject.asObserver()
        taskDate = dateSubject.asObserver()
        saveTrigger = saveSubject.asObserver()

        state = stateSubject
            .asDriver(onErrorJustReturn: .ready)

        self.setupSubscriptions()
    }

    // TODO: check for retain cycles and memory leaks
    private func setupSubscriptions() {
        stateSubject
            .subscribe(onNext: { [weak self] state_ in
                if case .display(let info) = state_ {
                    self?.taskTitleValue = info.title
                    self?.taskDescriptionValue = info.taskDescription
                    self?.taskDateValue = info.date
                }
            })
            .disposed(by: disposeBag)
        willAppearSubject
            .do(onNext: { self.stateSubject.onNext(.loading) })
            .flatMap { self.interactor.fetchTask(taskId: self.taskId ?? "")}
            .map { TaskEditViewInfo.from(task: $0) }
            .map { TaskEditViewState.display($0) }
            .bind(to: stateSubject)
            .disposed(by: disposeBag)
        titleSubject
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] value in
                self?.taskTitleValue = value
            })
            .disposed(by: disposeBag)
        descriptionSubject
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] value in
                self?.taskDescriptionValue = value
            })
            .disposed(by: disposeBag)
        dateSubject
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] value in
                self?.taskDateValue = value
            })
            .disposed(by: disposeBag)
        saveSubject
            .do(onNext: { self.stateSubject.onNext(.loading) })
            .map { Task(
                id: self.taskId ?? UUID().uuidString,
                title: self.taskTitleValue,
                taskDescription: self.taskDescriptionValue,
                date: self.taskDateValue
            )}
            .flatMap { self.interactor.save(task: $0) }
            .subscribe(onNext: {
                self.router.terminate()
            })
            .disposed(by: disposeBag)
    }
}
