//
//  ReuseIdentifiable.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/25/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol ReuseIdentifiable {
    static var reuseId: String { get }
}

extension ReuseIdentifiable where Self: UIView {
    static var reuseId: String {
        return String(describing: self)
    }
}
