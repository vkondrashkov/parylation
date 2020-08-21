//
//  PresentationScene.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 7/30/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class PresentationScene: Scene, PresentableScene {
    private weak var presentingViewController: UIViewController?
    
    var presentableView: UIViewController? {
        return presentingViewController
    }
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func play(view: UIViewController, animated: Bool, completion: (() -> Void)?) {
        presentingViewController?.present(view, animated: animated, completion: completion)
    }
    
    func play(scene: PresentableScene, animated: Bool, completion: (() -> Void)?) {
        guard let view = scene.presentableView else {
            completion?()
            return
        }
        play(view: view, animated: animated, completion: completion)
    }
    
    func stop(animated: Bool, completion: (() -> Void)?) {
        presentingViewController?.dismiss(animated: animated, completion: completion)
    }
}
