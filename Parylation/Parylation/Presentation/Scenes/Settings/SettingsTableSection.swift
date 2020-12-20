//
//  SettingsTableSection.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/25/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxDataSources

struct SettingsTableSection: SectionModelType {
    let name: String?
    let items: [SettingsTableItem]

    init(name: String?, items: [SettingsTableItem]) {
        self.name = name
        self.items = items
    }

    init(original: Self, items: [SettingsTableItem]) {
        self.name = nil
        self.items = items
    }
}
