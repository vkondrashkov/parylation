//
//  RootView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit
import RxSwift

final class RootView: UIViewController {
    var viewModel: RootViewModel!
    
    private let logoImageView = UIImageView()

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        UINavigationBar.appearance().tintColor = Color.gigas
        view.backgroundColor = Color.chablis
        view.addSubview(logoImageView)
        logoImageView.image = Asset.appLogo.image
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.snp.makeConstraints {
            $0.center.equalTo(view.safeAreaLayoutGuide.snp.center)
            $0.size.equalTo(248)
        }
    }
    
    private func bindViewModel() {
        rx.methodInvoked(#selector(UIViewController.viewDidAppear))
            .map { _ in () }
            .bind(to: viewModel.viewDidAppearTrigger)
            .disposed(by: disposeBag)
    }
}
