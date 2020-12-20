//
//  SettingsTableViewCellViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/26/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

protocol SettingsTableViewCellViewModel: AnyObject {
    var icon: Driver<UIImage?> { get }
    var color: Driver<UIColor> { get }
    var title: Driver<String> { get }
}

final class SettingsTableViewCellViewModelImpl: SettingsTableViewCellViewModel {
    let icon: Driver<UIImage?>
    let color: Driver<UIColor>
    let title: Driver<String>
    
    init(icon: UIImage?, color: UIColor, title: String) {
        self.icon = .just(icon)
        self.color = .just(color)
        self.title = .just(title)
    }
}
