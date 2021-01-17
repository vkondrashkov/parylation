//
// 
//  AlertViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import RxCocoa
import RxSwift

final class AlertViewModelImpl: AlertViewModel {
    private let router: AlertRouter
    private let viewInfo: AlertViewInfo

    let showTrigger: AnyObserver<Void>
    let terminateTrigger: AnyObserver<Void>

    let info: Driver<AlertViewInfo>

    private let disposeBag = DisposeBag()

    init(
        router: AlertRouter,
        viewInfo: AlertViewInfo
    ) {
        self.router = router
        self.viewInfo = viewInfo

        let showSubject = PublishSubject<Void>()
        showSubject
            .subscribe(onNext: {
                router.show()
            })
            .disposed(by: disposeBag)

        let terminateSubject = PublishSubject<Void>()
        terminateSubject
            .subscribe(onNext: {
                router.terminate()
            })
            .disposed(by: disposeBag)

        showTrigger = showSubject.asObserver()
        terminateTrigger = terminateSubject.asObserver()

        info = Observable.just(viewInfo)
            .asDriver(onErrorJustReturn: AlertViewInfo(content: [], actions: []))
    }
}
