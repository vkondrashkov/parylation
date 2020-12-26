//
// 
//  SettingsViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/25/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import RxCocoa
import RxSwift
import ParylationDomain

final class SettingsViewModelImpl: SettingsViewModel {
    private let interactor: SettingsInteractor
    private let router: SettingsRouter

    let selectTrigger: AnyObserver<IndexPath>

    let sections: Driver<[SettingsTableSection]>
    
    private let disposeBag = DisposeBag()

    init(
        interactor: SettingsInteractor,
        router: SettingsRouter
    ) {
        self.interactor = interactor
        self.router = router
        
        let items = Observable.just([
            SettingsTableSection(
                name: "Settings",
                items: [
                    SettingsTableItem(
                        icon: nil,
                        color: Color.gigas,
                        title: "Change username",
                        action: nil
                    ),
                    SettingsTableItem(
                        icon: nil,
                        color: Color.gigas,
                        title: "Change email",
                        action: nil
                    ),
                    SettingsTableItem(
                        icon: nil,
                        color: Color.gigas,
                        title: "Change password",
                        action: nil
                    )
                ]
            ),
            SettingsTableSection(
                name: "Others",
                items: [
                    SettingsTableItem(
                        icon: nil,
                        color: Color.marigoldYellow,
                        title: "Rate us",
                        action: nil
                    ),
                    SettingsTableItem(
                        icon: nil,
                        color: Color.marigoldYellow,
                        title: "About us",
                        action: nil
                    )
                ]
            ),
            SettingsTableSection(
                name: nil,
                items: [
                    SettingsTableItem(
                        icon: nil,
                        color: Color.blazeOrange,
                        title: "Sign out",
                        action: nil
                    )
                ]
            )
        ])
        
        let selectSubject = PublishSubject<IndexPath>()
        selectSubject
            .withLatestFrom(items) { ($0, $1) }
            .subscribe(onNext: { indexPath, sections in
                guard indexPath.section < sections.count,
                    indexPath.row < sections[indexPath.section].items.count else {
                        return
                }
                let item = sections[indexPath.section].items[indexPath.row]
                item.action?()
            })
            .disposed(by: disposeBag)

        selectTrigger = selectSubject.asObserver()

        sections = items.asDriver(onErrorJustReturn: [])
    }
}
