//
//  Scene.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 7/30/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

typealias AnyScene = Scene

protocol Scene {
    func play(view: UIViewController, animated: Bool, completion: (() -> Void)?)
    func stop(animated: Bool, completion: (() -> Void)?)
}
