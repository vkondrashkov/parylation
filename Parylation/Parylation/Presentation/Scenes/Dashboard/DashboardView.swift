//
//  DashboardView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit
import UIKit

final class DashboardView: UITabBarController {
    var viewModel: DashboardViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.viewWillAppearTrigger.receive()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        tabBar.tintColor = Color.gigas
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true
    }
    
    private func bindViewModel() {
        
    }
}
