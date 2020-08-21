//
//  NavigationScene.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 7/30/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class NavigationScene: Scene, PresentableScene {
    private weak var navigationController: UINavigationController?
    
    var presentableView: UIViewController? {
        return navigationController
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    convenience init?(viewController: UIViewController) {
        guard let navigationController = viewController.navigationController else {
            return nil
        }
        self.init(navigationController: navigationController)
    }
    
    func set(views: [UIViewController], animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        navigationController?.setViewControllers(views, animated: animated)
        CATransaction.commit()
    }
    
    func play(view: UIViewController, animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        navigationController?.pushViewController(view, animated: animated)
        CATransaction.commit()
    }
    
    func stop(animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        navigationController?.popViewController(animated: animated)
        CATransaction.commit()
    }
}
