//
// 
//  TaskViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import RxCocoa
import RxSwift
import ParylationDomain

final class TaskViewModelImpl: TaskViewModel {
    private let interactor: TaskInteractor
    private let router: TaskRouter
    private let taskId: String

    let willAppearTrigger: AnyObserver<Void>
    let deleteTrigger: AnyObserver<Void>
    let editTrigger: AnyObserver<Void>
    let completeTrigger: AnyObserver<Void>

    let state: Driver<TaskViewState>

    private let disposeBag = DisposeBag()

    init(
        interactor: TaskInteractor,
        router: TaskRouter,
        taskId: String
    ) {
        self.interactor = interactor
        self.router = router
        self.taskId = taskId

        let stateSubject = BehaviorSubject<TaskViewState>(value: .ready)

        let willAppearSubject = PublishSubject<Void>()
        willAppearSubject
            .do(onNext: { stateSubject.onNext(.loading) })
            .flatMap { interactor.fetchTask(taskId: taskId) }
            .map { TaskViewInfo.from(task: $0) }
            .map { TaskViewState.display($0) }
            .bind(to: stateSubject)
            .disposed(by: disposeBag)

        let deleteSubject = PublishSubject<Void>()
        deleteSubject
            .do(onNext: { stateSubject.onNext(.loading) })
            .flatMap { _ -> PublishSubject<Void> in
                let alertSubject = PublishSubject<Void>()
                let alertInfo = AlertViewInfoBuilderImpl()
                    .add(.title("Delete task?"))
                    .add(.text("This action can't be undone! Do you want to delete it anyway?"))
                    .add(.action(AlertViewInfo.ActionInfo(
                        name: "Cancel",
                        color: Color.gigas,
                        action: nil
                    )))
                    .add(.action(AlertViewInfo.ActionInfo(
                        name: "Delete",
                        color: Color.blazeOrange,
                        action: {
                            alertSubject.onNext(())
                        }
                    )))
                    .build()
                router.showAlert(info: alertInfo)
                return alertSubject.asObserver()
            }
            .flatMap { interactor.deleteTask(taskId: taskId) }
            .subscribe(onNext: {
                router.terminate()
            })
            .disposed(by: disposeBag)

        let editSubject = PublishSubject<Void>()
        editSubject
            .subscribe(onNext: {
                router.showTaskEdit(taskId: taskId, completion: nil)
            })
            .disposed(by: disposeBag)

        let completeSubject = PublishSubject<Void>()

        willAppearTrigger = willAppearSubject.asObserver()
        deleteTrigger = deleteSubject.asObserver()
        editTrigger = editSubject.asObserver()
        completeTrigger = completeSubject.asObserver()

        state = stateSubject.asDriver(onErrorJustReturn: .ready)
    }
}
