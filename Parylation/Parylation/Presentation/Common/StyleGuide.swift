//
//  StyleGuide.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 15.03.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

struct StyleGuide {
    struct Header {
        static let titleFontSize: CGFloat = Sizes.value(from: [.iPhone5s: 24], defaultValue: 28)
        static let subtitleFontSize: CGFloat = Sizes.value(from: [.iPhone5s: 20], defaultValue: 24)
        static let margins: CGFloat = Sizes.value(from: [.iPhone5s: 25], defaultValue: 30)
    }

    struct Screen {
        static let margins: CGFloat = Sizes.value(from: [.iPhone5s: 15], defaultValue: 20)
    }

    struct Label {
        static let fontSize: CGFloat = Sizes.value(from: [.iPhone5s: 15], defaultValue: 17)
    }

    struct Button {
        static let cornerRadius: CGFloat = Sizes.value(from: [.iPhone5s: 16], defaultValue: 20)
        static let height: CGFloat = Sizes.value(from: [.iPhone5s: 50], defaultValue: 60)
        static let fontSize: CGFloat = Sizes.value(from: [.iPhone5s: 13], defaultValue: 14)
    }

    struct TextField {
        static let cornerRadius: CGFloat = Sizes.value(from: [.iPhone5s: 12], defaultValue: 15)
        static let height: CGFloat = Sizes.value(from: [.iPhone5s: 50], defaultValue: 60)
    }
}
