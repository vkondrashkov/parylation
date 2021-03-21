//
//  Sizes.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 15.03.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

enum DeviceType {
    case iPhone4s
    case iPhone5s
    case iPhone8
    case iPhone8Plus // iPhone 12 Mini
    case iPhoneX // iPhone 11, 11 Pro, 11 Pro Max
    case iPad
}

struct Sizes {
    static func getCurrentDeviceType() -> DeviceType {
        if UI_USER_INTERFACE_IDIOM() == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 960:
                return .iPhone4s
            case 1136:
                return .iPhone5s
            case 1334:
                return .iPhone8
            case 1920, 2208, 2340:
                return .iPhone8Plus
            case 2436, 2688, 1792:
                return .iPhoneX
            default:
                return .iPhone8
            }
        } else {
            return .iPad
        }
    }

    static func value<T>(from values: [DeviceType: T], defaultValue: T? = nil) -> T {
        let currentDeviceType = Sizes.getCurrentDeviceType()
        return values[currentDeviceType] ?? defaultValue ?? values[.iPhone8]!
    }
}
