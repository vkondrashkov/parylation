//
//  Color.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 19.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

public struct Color {
    public let id: String
    public let value: UIColor

    public init(id: String, value: UIColor) {
        self.id = id
        self.value = value
    }
}
