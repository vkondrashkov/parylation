//
//  SettingsTableSection.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/25/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit

struct SettingsTableSection {
    let name: String?
    let items: [SettingsTableItem]
}

extension SettingsTableSection: SectionedDataSourceChangesetConvertible {
    var asSectionedDataSourceChangeset: OrderedCollectionChangeset<[SettingsTableItem]> {
        return OrderedCollectionChangeset(collection: items, patch: [])
    }
}
