//
//  SettingsTableViewCellViewModel.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/26/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit
import ReactiveKit

protocol SettingsTableViewCellViewModel: AnyObject {
    var icon: SafeSignal<UIImage?> { get }
    var color: SafeSignal<UIColor> { get }
    var title: SafeSignal<String> { get }
}

final class SettingsTableViewCellViewModelImpl: SettingsTableViewCellViewModel {
    let icon: SafeSignal<UIImage?>
    let color: SafeSignal<UIColor>
    let title: SafeSignal<String>
    
    init(icon: UIImage?, color: UIColor, title: String) {
        self.icon = SafeSignal(just: icon)
        self.color = SafeSignal(just: color)
        self.title = SafeSignal(just: title)
    }
}
