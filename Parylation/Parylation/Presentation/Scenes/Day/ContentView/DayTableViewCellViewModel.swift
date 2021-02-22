//
//  DayTableViewCellViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 10.02.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

protocol DayTableViewCellViewModel: AnyObject {
    var icon: Driver<UIImage?> { get }
    var color: Driver<UIColor> { get }
    var title: Driver<String> { get }
}

final class DayTableViewCellViewModelImpl: DayTableViewCellViewModel {
    let icon: Driver<UIImage?>
    let color: Driver<UIColor>
    let title: Driver<String>

    init(icon: UIImage?, color: UIColor, title: String) {
        self.icon = .just(icon)
        self.color = .just(color)
        self.title = .just(title)
    }
}
