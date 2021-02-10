//
//  DashboardView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class DashboardView: UITabBarController {
    var viewModel: DashboardViewModel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.viewWillAppearTrigger.onNext(())
        setupUI()
    }
    
    private func setupUI() {
        tabBar.tintColor = Color.gigas
        tabBar.backgroundColor = .white
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true
    }
}
