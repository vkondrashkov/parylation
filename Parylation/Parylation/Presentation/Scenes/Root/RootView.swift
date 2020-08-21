//
//  RootView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class RootView: UINavigationController {
    var viewModel: RootViewModel!
    
    private let logoImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Temp
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: { [weak self] in
            self?.view.backgroundColor = .clear
            self?.logoImageView.removeFromSuperview()
            self?.viewModel.viewDidAppearTrigger.send()
        })
    }
    
    private func setupUI() {
        setNavigationBarHidden(true, animated: false)
        interactivePopGestureRecognizer?.delegate = self
        
        view.backgroundColor = Color.chablis
        view.addSubview(logoImageView)
        logoImageView.image = UIImage(named: "app_logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.snp.makeConstraints {
            $0.center.equalTo(view.safeAreaLayoutGuide.snp.center)
            $0.size.equalTo(248)
//            $0.size.equalTo(270)
        }
    }
    
    private func bindViewModel() {
        
    }
}

extension RootView: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
