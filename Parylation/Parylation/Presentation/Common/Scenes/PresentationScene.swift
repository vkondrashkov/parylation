//
//  PresentationScene.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 7/30/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class PresentationScene: Scene {
    private weak var presentingViewController: UIViewController?
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func play(view: UIViewController, animated: Bool, completion: (() -> Void)?) {
        presentingViewController?.present(view, animated: animated, completion: completion)
    }
    
    func stop(animated: Bool, completion: (() -> Void)?) {
        presentingViewController?.dismiss(animated: animated, completion: completion)
    }
}
