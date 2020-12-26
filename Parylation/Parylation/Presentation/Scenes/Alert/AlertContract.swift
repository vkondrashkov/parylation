//
// 
//  AlertContract.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import RxCocoa
import RxSwift
import UIKit

protocol AlertContainer { }

protocol AlertBuilder {
    func build(info: AlertViewInfo) -> UIViewController
}

protocol AlertRouter: AnyObject {
    func terminate()
}

protocol AlertViewModel {
    var terminateTrigger: AnyObserver<Void> { get }

    var info: Driver<AlertViewInfo> { get }
}
