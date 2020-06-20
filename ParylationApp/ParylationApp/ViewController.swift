//
//  ViewController.swift
//  ParylationApp
//
//  Created by Vladislav Kondrashkov on 6/19/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit
import ParylationDomain

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let test = SomeTest()
        test.sayHello()
    }


}

