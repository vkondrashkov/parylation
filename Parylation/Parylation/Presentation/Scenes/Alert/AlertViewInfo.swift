//
//  AlertViewInfo.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

enum AlertViewInfoItem {
    typealias TextProvider = () -> String
    typealias TextConsumer = (String) -> Void

    typealias SwitchProvider = () -> Bool
    typealias SwitchConsumer = (Bool) -> Void

    case title(String)
    case text(String)
    case textField(TextProvider, TextConsumer)
    case toggle(SwitchProvider, SwitchConsumer)
    case action(AlertViewInfo.ActionInfo)

    case combined([AlertViewInfoItem])
}

struct AlertViewInfo {
    struct ActionInfo {
        let name: String
        let color: UIColor
        let action: (() -> Void)?
    }

    let content: [AlertViewInfoItem]
    let actions: [ActionInfo]
}
