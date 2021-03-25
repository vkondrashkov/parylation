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
    private let data: TaskEditData?

    private var taskTitleValue = ""
    private var taskDescriptionValue = ""
    private var taskDateValue = Date()

    let taskTitle: AnyObserver<String>
    let taskDescription: AnyObserver<String>
    let taskDate: AnyObserver<Date>

    let willAppearTrigger: AnyObserver<Void>
    let iconSelectionTrigger: AnyObserver<IndexPath>
    let colorSelectionTrigger: AnyObserver<IndexPath>
    let saveTrigger: AnyObserver<Void>

    let taskIcon: Driver<UIImage>
    let taskColor: Driver<UIColor>
    let state: Driver<TaskEditViewState>
    let icons: Driver<[Icon]>
    let colors: Driver<[ParylationDomain.Color]>

    private let disposeBag = DisposeBag()

    init(
        interactor: TaskEditInteractor,
        router: TaskEditRouter,
        data: TaskEditData? = nil
    ) {
        self.interactor = interactor
        self.router = router
        self.data = data

        let titleSubject = PublishSubject<String>()
        let descriptionSubject = PublishSubject<String>()
        let dateSubject = PublishSubject<Date>()

        let stateSubject = PublishSubject<TaskEditViewState>()

        let willAppearSubject = ReplaySubject<Void>.create(bufferSize: 1)
        let editData = willAppearSubject
            .do(onNext: { stateSubject.onNext(.loading) })
            .compactMap { data }

        let presettedIcon = editData
            .flatMap { interactor.fetchIcon(id: $0.iconId ?? "") }

        let presettedColor = editData
            .flatMap { interactor.fetchColor(id: $0.colorId ?? "") }

        let editViewInfo = Observable
            .combineLatest(editData, presettedIcon, presettedColor)
            .map { data, icon, color -> TaskEditViewInfo in
                .from(data: data, icon: icon, color: color)
            }

        willAppearSubject
            .flatMap { _ -> Observable<TaskEditViewState> in
                if data != nil {
                    return editViewInfo
                        .map { .display($0) }
                } else {
                    return .just(.ready)
                }
            }
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

        let fetchedIcons = interactor.fetchIcons()
            .asObservable()
            .share()
        let iconSelectionSubject = PublishSubject<IndexPath>()
        let selectedIcon = iconSelectionSubject
            .withLatestFrom(fetchedIcons) {
                return $1[$0.row]
            }
        let displayingIcon = selectedIcon
            .map { $0.image }

        fetchedIcons
            .map { icons_ -> IndexPath in
                let defaultIndexPath = IndexPath(row: 0, section: 0)
                var indexPath = defaultIndexPath
                if let presetIconId = data?.iconId {
                    let presetIconIndex = icons_.firstIndex(where: { $0.id == presetIconId }) ?? 0
                    indexPath = IndexPath(row: presetIconIndex, section: 0)
                }
                return indexPath
            }
            .bind(onNext: iconSelectionSubject.onNext)
            .disposed(by: disposeBag)

        let fetchedColors = interactor.fetchColors()
            .asObservable()
            .share()
        let colorSelectionSubject = PublishSubject<IndexPath>()
        let selectedColor = colorSelectionSubject
            .withLatestFrom(fetchedColors) {
                return $1[$0.row]
            }
        let displayingColor = selectedColor
            .map { $0.value }

        fetchedColors
            .map { colors_ -> IndexPath in
                let defaultIndexPath = IndexPath(row: 0, section: 0)
                var indexPath = defaultIndexPath
                if let presetColorId = data?.colorId {
                    let presetColorIndex = colors_.firstIndex(where: { $0.id == presetColorId }) ?? 0
                    indexPath = IndexPath(row: presetColorIndex, section: 0)
                }
                return indexPath
            }
            .bind(onNext: colorSelectionSubject.onNext)
            .disposed(by: disposeBag)

        let date = dateSubject
            .distinctUntilChanged()

        let taskData = Observable
            .combineLatest(title, description, selectedIcon, selectedColor, date)
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
                id: data?.id ?? UUID().uuidString,
                iconId: $2.id,
                colorId: $3.id,
                title: $0,
                taskDescription: $1,
                date: $4
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

        taskTitle = titleSubject.asObserver()
        taskDescription = descriptionSubject.asObserver()
        taskDate = dateSubject.asObserver()

        willAppearTrigger = willAppearSubject.asObserver()
        iconSelectionTrigger = iconSelectionSubject.asObserver()
        colorSelectionTrigger = colorSelectionSubject.asObserver()
        saveTrigger = saveSubject.asObserver()

        taskIcon = displayingIcon
            .asDriver(onErrorJustReturn: Asset.taskEditList.image)
        taskColor = displayingColor
            .asDriver(onErrorJustReturn: Color.gigas)
        state = stateSubject
            .asDriver(onErrorJustReturn: .ready)
        icons = fetchedIcons
            .asDriver(onErrorJustReturn: [])
        colors = fetchedColors
            .asDriver(onErrorJustReturn: [])
    }
}
