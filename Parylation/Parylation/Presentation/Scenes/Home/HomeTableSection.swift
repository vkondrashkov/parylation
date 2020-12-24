//
//  HomeTableSection.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 20.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxDataSources

struct HomeTableSection: SectionModelType {
    let name: String
    let items: [HomeTableItem]

    init(name: String, items: [HomeTableItem]) {
        self.name = name
        self.items = items
    }

    init(original: Self, items: [HomeTableItem]) {
        self.name = ""
        self.items = items
    }
}
