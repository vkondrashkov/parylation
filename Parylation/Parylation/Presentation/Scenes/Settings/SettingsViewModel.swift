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

    private let userSubject = BehaviorSubject<Void>(value: ())
    private let updateUsernameSubject = PublishSubject<Void>()
    private let updateEmailSubject = PublishSubject<Void>()
    private let updatePasswordSubject = PublishSubject<Void>()
    private let signOutSubject = PublishSubject<Void>()

    let selectTrigger: AnyObserver<IndexPath>

    let sections: Driver<[SettingsTableSection]>
    
    private let disposeBag = DisposeBag()

    init(
        interactor: SettingsInteractor,
        router: SettingsRouter
    ) {
        self.interactor = interactor
        self.router = router

        let user = userSubject
            .flatMap { interactor.fetchUser() }
            .asObservable()
            .share(replay: 1)

        let emailSubject = PublishSubject<String>()
        user
            .map { $0.email }
            .bind(to: emailSubject)
            .disposed(by: disposeBag)

        let updateEmailSubject_ = updateEmailSubject
        updateEmailSubject
            .withLatestFrom(emailSubject)
            .flatMap { interactor.update(email: $0) }
            .bind(onNext: userSubject.onNext)
            .disposed(by: disposeBag)

        let usernameSubject = PublishSubject<String>()
        user
            .map { $0.username }
            .bind(to: usernameSubject)
            .disposed(by: disposeBag)

        let updateUsernameSubject_ = updateUsernameSubject
        updateUsernameSubject
            .withLatestFrom(usernameSubject)
            .flatMap { interactor.update(username: $0) }
            .bind(onNext: userSubject.onNext)
            .disposed(by: disposeBag)

        let signOutSubject_ = signOutSubject
        signOutSubject
            .flatMap { interactor.signout() }
            .subscribe(onNext: {
                router.terminate()
            })
            .disposed(by: disposeBag)

        // TODO: revisit, doubled events
        let items = user
            .map { user_ -> [SettingsTableSection] in
                [
                    SettingsTableSection(
                        name: L10n.settingsMainSection,
                        items: [
                            SettingsTableItem(
                                icon: Asset.settingsChangeUsername.image.withRenderingMode(.alwaysTemplate),
                                color: Color.gigas,
                                title: L10n.settingsMainChangeUsername,
                                action: {
                                    let alertViewInfo = AlertViewInfoBuilderImpl()
                                        .add(.title(L10n.settingsMainChangeUsername))
                                        .add(.textField({ user_.username }, { usernameSubject.onNext($0) }))
                                        .add(.action(AlertViewInfo.ActionInfo(
                                            name: L10n.cancel,
                                            color: Color.gigas,
                                            action: nil
                                        )))
                                        .add(.action(AlertViewInfo.ActionInfo(
                                            name: L10n.accept,
                                            color: Color.shamrock,
                                            action: {
                                                updateUsernameSubject_.onNext(())
                                            }
                                        )))
                                        .build()
                                    router.showAlert(info: alertViewInfo)
                                }
                            ),
                            SettingsTableItem(
                                icon: Asset.settingsChangeEmail.image.withRenderingMode(.alwaysTemplate),
                                color: Color.gigas,
                                title: L10n.settingsMainChangeEmail,
                                action: {
                                    let alertViewInfo = AlertViewInfoBuilderImpl()
                                        .add(.title(L10n.settingsMainChangeEmail))
                                        .add(.textField({ user_.email }, { emailSubject.onNext($0) }))
                                        .add(.action(AlertViewInfo.ActionInfo(
                                            name: L10n.cancel,
                                            color: Color.gigas,
                                            action: nil
                                        )))
                                        .add(.action(AlertViewInfo.ActionInfo(
                                            name: L10n.accept,
                                            color: Color.shamrock,
                                            action: {
                                                updateEmailSubject_.onNext(())
                                            }
                                        )))
                                        .build()
                                    router.showAlert(info: alertViewInfo)
                                }
                            ),
                            SettingsTableItem(
                                icon: Asset.settingsChangePassword.image.withRenderingMode(.alwaysTemplate),
                                color: Color.gigas,
                                title: L10n.settingsMainChangePassword,
                                action: {
                                    let alertViewInfo = AlertViewInfoBuilderImpl()
                                        .add(.title(L10n.settingsMainChangePassword))
                                        .add(.text(L10n.settingsPopupOldPassword))
                                        .add(.textField({ "" }, { _ in }))
                                        .add(.text(L10n.settingsPopupNewPassword))
                                        .add(.textField({ "" }, { _ in }))
                                        .add(.text(L10n.settingsPopupConfirmNewPassword))
                                        .add(.textField({ "" }, { _ in }))
                                        .add(.action(AlertViewInfo.ActionInfo(
                                            name: L10n.cancel,
                                            color: Color.gigas,
                                            action: nil
                                        )))
                                        .add(.action(AlertViewInfo.ActionInfo(
                                            name: L10n.accept,
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
                                icon: Asset.settingsRateUs.image.withRenderingMode(.alwaysTemplate),
                                color: Color.marigoldYellow,
                                title: L10n.settingsOthersRateUs,
                                action: {
                                    let alertViewInfo = AlertViewInfoBuilderImpl()
                                        .add(.title(L10n.unavailableFeatureTitle))
                                        .add(.text(L10n.unavailableFeatureDescription))
                                        .add(.action(AlertViewInfo.ActionInfo(
                                            name: L10n.ok,
                                            color: Color.gigas,
                                            action: nil
                                        )))
                                        .build()
                                    router.showAlert(info: alertViewInfo)
                                }
                            ),
                            SettingsTableItem(
                                icon: Asset.settingsAboutUs.image.withRenderingMode(.alwaysTemplate),
                                color: Color.marigoldYellow,
                                title: L10n.settingsOthersAboutUs,
                                action: {
                                    let alertViewInfo = AlertViewInfoBuilderImpl()
                                        .add(.title(L10n.unavailableFeatureTitle))
                                        .add(.text(L10n.unavailableFeatureDescription))
                                        .add(.action(AlertViewInfo.ActionInfo(
                                            name: L10n.ok,
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
                                icon: Asset.settingsSignout.image.withRenderingMode(.alwaysTemplate),
                                color: Color.blazeOrange,
                                title: L10n.settingsSignOut,
                                action: {
                                    let alertViewInfo = AlertViewInfoBuilderImpl()
                                        .add(.title(L10n.settingsPopupSignoutTitle))
                                        .add(.text(L10n.settingsPopupSignoutDescription))
                                        .add(.action(AlertViewInfo.ActionInfo(
                                            name: L10n.cancel,
                                            color: Color.gigas,
                                            action: nil
                                        )))
                                        .add(.action(AlertViewInfo.ActionInfo(
                                            name: L10n.settingsPopupSignoutConfirm,
                                            color: Color.blazeOrange,
                                            action: {
                                                signOutSubject_.onNext(())
                                            }
                                        )))
                                        .build()
                                    router.showAlert(info: alertViewInfo)
                                }
                            )
                        ]
                    )
                ]
            }

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
