//
//  SettingsTableItem.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/25/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

struct SettingsTableItem {
    let icon: UIImage?
    let color: UIColor
    let title: String
    let action: (() -> Void)?
}
