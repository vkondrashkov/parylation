//
//  CALayer+Shadow.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

extension CALayer {
    func applyShadow(color: UIColor,
                     alpha: Float,
                     x: CGFloat,
                     y: CGFloat,
                     blur: CGFloat,
                     spread: CGFloat) {
        self.shadowColor = color.cgColor
        self.shadowOpacity = alpha
        self.shadowOffset = CGSize(width: x, height: y)
        self.shadowRadius = blur / 2.0
        if spread == 0 {
            self.shadowPath = nil
        } else {
            let rect = bounds.insetBy(dx: -spread, dy: -spread)
            self.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
