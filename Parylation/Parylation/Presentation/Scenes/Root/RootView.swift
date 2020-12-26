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
    
    private let logoImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppearTrigger.onNext(())
    }
    
    private func setupUI() {
        view.backgroundColor = Color.chablis
        view.addSubview(logoImageView)
        logoImageView.image = UIImage(named: "app_logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.snp.makeConstraints {
            $0.center.equalTo(view.safeAreaLayoutGuide.snp.center)
            $0.size.equalTo(248)
        }
    }
    
    private func bindViewModel() {
        
    }
}
