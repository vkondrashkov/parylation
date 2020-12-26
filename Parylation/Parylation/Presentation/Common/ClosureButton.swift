//
//  ClosureButton.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class ClosureButton: UIButton {
    var didTouchUpInside: (() -> Void)? {
        didSet {
            if didTouchUpInside != nil {
                addTarget(self, action: #selector(didTouchUpInside(_:)), for: .touchUpInside)
            } else {
                removeTarget(self, action: #selector(didTouchUpInside(_:)), for: .touchUpInside)
            }
        }
    }

    @objc private func didTouchUpInside(_ sender: UIButton) {
        didTouchUpInside?()
    }
}
