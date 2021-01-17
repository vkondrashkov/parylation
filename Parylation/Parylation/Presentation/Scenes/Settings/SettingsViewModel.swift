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

        let disposeBag_ = disposeBag
        let items = Observable.just([
            SettingsTableSection(
                name: L10n.settingsMainSection,
                items: [
                    SettingsTableItem(
                        icon: UIImage(named: "settings-change_username"),
                        color: Color.gigas,
                        title: L10n.settingsMainChangeUsername,
                        action: {
                            let alertViewInfo = AlertViewInfoBuilderImpl()
                                .add(.title("Change username"))
                                .add(.textField({ "vkondrashkov" }, { _ in }))
                                .add(.action(AlertViewInfo.ActionInfo(
                                    name: "Cancel",
                                    color: Color.gigas,
                                    action: nil
                                )))
                                .add(.action(AlertViewInfo.ActionInfo(
                                    name: "Accept",
                                    color: Color.shamrock,
                                    action: {
//                                        alertSubject.onNext(())
                                    }
                                )))
                                .build()
                            router.showAlert(info: alertViewInfo)
                        }
                    ),
                    SettingsTableItem(
                        icon: UIImage(named: "settings-change_email"),
                        color: Color.gigas,
                        title: L10n.settingsMainChangeEmail,
                        action: {
                            let alertViewInfo = AlertViewInfoBuilderImpl()
                                .add(.title("Change email"))
                                .add(.textField({ "vladislav@kondrashkov.com" }, { _ in }))
                                .add(.action(AlertViewInfo.ActionInfo(
                                    name: "Cancel",
                                    color: Color.gigas,
                                    action: nil
                                )))
                                .add(.action(AlertViewInfo.ActionInfo(
                                    name: "Accept",
                                    color: Color.shamrock,
                                    action: {
//                                        alertSubject.onNext(())
                                    }
                                )))
                                .build()
                            router.showAlert(info: alertViewInfo)
                        }
                    ),
                    SettingsTableItem(
                        icon: UIImage(named: "settings-change_password"),
                        color: Color.gigas,
                        title: L10n.settingsMainChangePassword,
                        action: {
                            let alertViewInfo = AlertViewInfoBuilderImpl()
                                .add(.title("Change password"))
                                .add(.text("Old password"))
                                .add(.textField({ "" }, { _ in }))
                                .add(.text("New password"))
                                .add(.textField({ "" }, { _ in }))
                                .add(.text("Confirm new password"))
                                .add(.textField({ "" }, { _ in }))
                                .add(.action(AlertViewInfo.ActionInfo(
                                    name: "Cancel",
                                    color: Color.gigas,
                                    action: nil
                                )))
                                .add(.action(AlertViewInfo.ActionInfo(
                                    name: "Accept",
                                    color: Color.shamrock,
                                    action: {
//                                        alertSubject.onNext(())
                                    }
                                )))
                                .build()
                            router.showAlert(info: alertViewInfo)
                        }
                    )
                ]
            ),
            SettingsTableSection(
                name: L10n.settingsOthersSection,
                items: [
                    SettingsTableItem(
                        icon: UIImage(named: "settings-rate_us"),
                        color: Color.marigoldYellow,
                        title: L10n.settingsOthersRateUs,
                        action: {
                            let alertViewInfo = AlertViewInfoBuilderImpl()
                                .add(.title("Oh no..."))
                                .add(.text("This feature is not working yet. Try again later ;("))
                                .add(.action(AlertViewInfo.ActionInfo(
                                    name: "Ok",
                                    color: Color.gigas,
                                    action: nil
                                )))
                                .build()
                            router.showAlert(info: alertViewInfo)
                        }
                    ),
                    SettingsTableItem(
                        icon: UIImage(named: "settings-about_us"),
                        color: Color.marigoldYellow,
                        title: L10n.settingsOthersAboutUs,
                        action: {
                            let alertViewInfo = AlertViewInfoBuilderImpl()
                                .add(.title("Oh no..."))
                                .add(.text("This feature is not working yet. Try again later ;("))
                                .add(.action(AlertViewInfo.ActionInfo(
                                    name: "Ok",
                                    color: Color.gigas,
                                    action: nil
                                )))
                                .build()
                            router.showAlert(info: alertViewInfo)
                        }
                    )
                ]
            ),
            SettingsTableSection(
                name: nil,
                items: [
                    SettingsTableItem(
                        icon: UIImage(named: "settings-signout"),
                        color: Color.blazeOrange,
                        title: L10n.settingsSignOut,
                        action: {
                            let alertViewInfo = AlertViewInfoBuilderImpl()
                                .add(.title("Are you sure?"))
                                .add(.text("This action can't be undone! Do you want to quit anyway?"))
                                .add(.action(AlertViewInfo.ActionInfo(
                                    name: "Cancel",
                                    color: Color.gigas,
                                    action: nil
                                )))
                                .add(.action(AlertViewInfo.ActionInfo(
                                    name: "Quit",
                                    color: Color.blazeOrange,
                                    action: {
                                        interactor.signout()
                                            .asObservable()
                                            .subscribe(onNext: {
                                                router.terminate()
                                            })
                                            .disposed(by: disposeBag_)
                                    }
                                )))
                                .build()
                            router.showAlert(info: alertViewInfo)
                        }
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
