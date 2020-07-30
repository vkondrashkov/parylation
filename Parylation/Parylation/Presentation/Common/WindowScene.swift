//
//  WindowScene.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 7/30/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class WindowScene: Scene {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func play(view: UIViewController, animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        window.rootViewController = view
        window.makeKeyAndVisible()
        CATransaction.commit()
    }
    
    func stop(animated: Bool, completion: (() -> Void)?) {
        window.resignKey()
        window.rootViewController = nil
        completion?()
    }
}
