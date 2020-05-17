//
//  RootView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class RootView: UIViewController {
    var viewModel: RootViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        
        viewModel.viewDidLoadTrigger.send()
    }
    
    private func bindViewModel() {
        
    }
}
