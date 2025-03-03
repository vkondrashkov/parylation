//
//  
//  AlertBuilder.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import UIKit

final class AlertBuilderImpl: AlertBuilder {
    func build(info: AlertViewInfo) -> SelfDisplayable {
        let view = AlertView()
        view.modalPresentationStyle = .overCurrentContext
        view.modalTransitionStyle = .crossDissolve
        let router = AlertRouterImpl(
            viewController: view
        )
        let viewModel = AlertViewModelImpl(
            router: router,
            viewInfo: info
        ) 
        view.viewModel = viewModel
        return view
    }
}
