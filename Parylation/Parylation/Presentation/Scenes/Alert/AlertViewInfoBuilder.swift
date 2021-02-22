//
//  AlertViewInfoBuilder.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 16.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

protocol AlertViewInfoBuilder {
    func add(_ item: AlertViewInfoItem) -> Self
    func build() -> AlertViewInfo
}

final class AlertViewInfoBuilderImpl: AlertViewInfoBuilder {
    var items: [AlertViewInfoItem] = []
    var actions: [AlertViewInfo.ActionInfo] = []

    func add(_ item: AlertViewInfoItem) -> AlertViewInfoBuilderImpl {
        if case .action(let action) = item {
            actions.append(action)
        } else {
            items.append(item)
        }
        return self
    }

    func build() -> AlertViewInfo {
        return AlertViewInfo(
            content: items,
            actions: actions
        )
    }
}
