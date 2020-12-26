//
//  AlertViewInfo.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

struct AlertViewInfo {
    struct ActionInfo {
        let name: String
        let color: UIColor
        let action: (() -> Void)?
    }

    let title: String
    let message: String
    let actions: [ActionInfo]
}
