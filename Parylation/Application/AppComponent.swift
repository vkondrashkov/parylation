//
//  AppComponent.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class AppComponent {
    unowned let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
}
