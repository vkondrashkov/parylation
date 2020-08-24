//
//  WelcomeView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit
import UIKit

final class WelcomeView: UIViewController {
    var viewModel: WelcomeViewModel!
    
    private let contentBackgroundView = UIView()
    private let contentView = UIView()
    private let logoImageView = UIImageView()
    private let subtitleLabel = UILabel()
    private let titleLabel = UILabel()
    private let signUpButton = UIButton()
    private let signInButton = UIButton()
    private let imageBackgroundView = UIView()
    private let homeIndicatorMaskView = UIView()
    private let imageView = UIImageView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    override func loadView() {
        view = UIView()
        
        view.addSubview(contentBackgroundView)
        contentBackgroundView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.snp.centerY)
        }
        
        contentBackgroundView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.top.greaterThanOrEqualToSuperview()
            $0.trailing.bottom.lessThanOrEqualToSuperview()
        }
        
        contentView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.size.equalTo(75)
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        contentView.addSubview(signUpButton)
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.width.equalTo(200)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        contentView.addSubview(signInButton)
        signInButton.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        view.addSubview(imageBackgroundView)
        imageBackgroundView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.snp.centerY)
        }
        
        view.insertSubview(homeIndicatorMaskView, belowSubview: imageBackgroundView)
        homeIndicatorMaskView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(imageBackgroundView.snp.centerY)
        }
        
        imageBackgroundView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        logoImageView.image = UIImage(named: "app_logo")
        
        subtitleLabel.font = .systemFont(ofSize: 24, weight: .ultraLight)
        subtitleLabel.text = "Plan Your Day with" // localize
        subtitleLabel.textColor = .black
        
        titleLabel.font = .systemFont(ofSize: 32, weight: .heavy)
        titleLabel.text = "PARYLATION" // localize
        titleLabel.textColor = Color.gigas
        
        signUpButton.setTitle("SIGN UP", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.backgroundColor = Color.marigoldYellow
        signUpButton.layer.cornerRadius = 20
        if #available(iOS 13.0, *) {
            signUpButton.layer.cornerCurve = .continuous
        }
        signUpButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        signUpButton.layer.applyShadow(
            color: Color.marigoldYellow,
            alpha: 0.5,
            x: 0,
            y: 5,
            blur: 20,
            spread: -20
        )
        
        signInButton.setTitle("I already have an account", for: .normal)
        signInButton.setTitleColor(Color.dustyGray, for: .normal)
        signInButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        
        homeIndicatorMaskView.backgroundColor = Color.gigas
        
        imageBackgroundView.backgroundColor = Color.gigas
        imageBackgroundView.layer.cornerRadius = 40
        if #available(iOS 13.0, *) {
            imageBackgroundView.layer.cornerCurve = .continuous
        }
        
        imageView.image = UIImage(named: "welcome_background")
        imageView.contentMode = .scaleAspectFit
    }
    
    private func bindViewModel() {
        signUpButton.reactive.tap
            .bind(to: viewModel.signUpTrigger)
        
        signInButton.reactive.tap
            .bind(to: viewModel.signInTrigger)
    }
}
