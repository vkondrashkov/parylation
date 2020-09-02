//
// 
//  SettingsViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/25/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import Bond
import ReactiveKit
import ParylationDomain

final class SettingsViewModelImpl: SettingsViewModel {
    private let interactor: SettingsInteractor
    private let router: SettingsRouter
    
    /// Input
    let selectTrigger: Subject<IndexPath, Never>
    
    /// Ouput
    let sections: SafeSignal<Array2D<String?, SettingsTableItem>>
    
    private let disposeBag = DisposeBag()

    init(
        interactor: SettingsInteractor,
        router: SettingsRouter
    ) {
        self.interactor = interactor
        self.router = router
        
        let items = SafeSignal<Array2D<String?, SettingsTableItem>> { observer in
            observer.receive(Array2D(sectionsWithItems: [
                ("Settings", [
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
                ]),
                ("Others", [
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
                ]),
                (nil, [
                    SettingsTableItem(
                        icon: nil,
                        color: Color.blazeOrange,
                        title: "Sign out",
                        action: nil
                    )
                ])
            ]))
            return SimpleDisposable()
        }
        
        let selectSubject = PassthroughSubject<IndexPath, Never>()
        selectSubject
            .with(latestFrom: items)
            .observeNext { indexPath, sections in
                guard indexPath.section < sections.count,
                    indexPath.row < sections[indexPath.section].items.count else {
                        return
                }
                let item = sections[indexPath.section].items[indexPath.row]
                item.action?()
            }
            .dispose(in: disposeBag)
        
        /// Input
        selectTrigger = selectSubject
        
        /// Output
        sections = items
    }
}
