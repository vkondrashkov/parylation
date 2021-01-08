//
//  CommonTextFormatter.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 7.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

final class CommonTextFormatter {
    func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        return formatter.string(from: date)
    }
}
