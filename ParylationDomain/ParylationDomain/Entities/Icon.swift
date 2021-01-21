//
//  Icon.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 19.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

public struct Icon {
    public let id: String
    public let image: UIImage

    public init(id: String, image: UIImage) {
        self.id = id
        self.image = image
    }
}
