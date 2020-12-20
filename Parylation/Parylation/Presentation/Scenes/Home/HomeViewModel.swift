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
    
    private let disposeBag = DisposeBag()
    
    init(
        interactor: HomeInteractor,
        router: HomeRouter
    ) {
        self.interactor = interactor
        self.router = router
    }
}
