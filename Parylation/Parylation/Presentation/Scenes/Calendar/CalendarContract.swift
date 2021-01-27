//
// 
//  CalendarContract.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 27.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//
//

import UIKit

protocol CalendarContainer { }

protocol CalendarBuilder {
    func build() -> UIViewController
}

protocol CalendarRouter: AnyObject { }

protocol CalendarViewModel { }
