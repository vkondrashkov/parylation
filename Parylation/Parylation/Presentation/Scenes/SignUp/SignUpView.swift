//
//  SignUpView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit
import UIKit

final class SignUpView: UIViewController {
    var viewModel: SignUpViewModel!
    
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let emailCaptionLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordCaptionLabel = UILabel()
    private let passwordTextField = UITextField()
    private let confirmPasswordCaptionLabel = UILabel()
    private let confirmPasswordTextField = UITextField()
    private let signUpButton = UIButton()
    private let signInCaption = UILabel()
    private let signInButton = UIButton()
    
    override func loadView() {
        view = UIView()
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
            $0.top.greaterThanOrEqualToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        contentView.addSubview(emailCaptionLabel)
        emailCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        contentView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailCaptionLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        contentView.addSubview(passwordCaptionLabel)
        passwordCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(25)
            $0.leading.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        contentView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordCaptionLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        contentView.addSubview(confirmPasswordCaptionLabel)
        confirmPasswordCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(25)
            $0.leading.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        contentView.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordCaptionLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        contentView.addSubview(signUpButton)
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordTextField.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        let signInView = UIView()
        contentView.addSubview(signInView)
        signInView.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        signInView.addSubview(signInCaption)
        signInCaption.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
        
        signInView.addSubview(signInButton)
        signInButton.snp.makeConstraints {
            $0.leading.equalTo(signInCaption.snp.trailing).offset(5)
            $0.top.bottom.trailing.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = Color.whisper
        
        titleLabel.font = .systemFont(ofSize: 56)
        titleLabel.text = "🤝"
        
        subtitleLabel.font = .systemFont(ofSize: 24, weight: .ultraLight)
        subtitleLabel.text = "Start using Parylation!" // localize
        subtitleLabel.textColor = .black
        
        emailCaptionLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        emailCaptionLabel.text = "Email"
        emailCaptionLabel.textColor = Color.gigas
        
        emailTextField.backgroundColor = .white
        emailTextField.layer.cornerRadius = 15
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 2))
        emailTextField.leftViewMode = .always
        emailTextField.placeholder = "example@domain.com"
        emailTextField.keyboardType = .emailAddress
        
        passwordCaptionLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        passwordCaptionLabel.text = "Password"
        passwordCaptionLabel.textColor = Color.gigas
        
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 2))
        passwordTextField.leftViewMode = .always
        passwordTextField.isSecureTextEntry = true
        
        confirmPasswordCaptionLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        confirmPasswordCaptionLabel.text = "Confirm password"
        confirmPasswordCaptionLabel.textColor = Color.gigas
        
        confirmPasswordTextField.backgroundColor = .white
        confirmPasswordTextField.layer.cornerRadius = 15
        confirmPasswordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 2))
        confirmPasswordTextField.leftViewMode = .always
        confirmPasswordTextField.isSecureTextEntry = true
        
        signUpButton.setTitle("SIGN UP", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = Color.blazeOrange
        signUpButton.layer.cornerRadius = 20
        if #available(iOS 13.0, *) {
            signUpButton.layer.cornerCurve = .continuous
        }
        signUpButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        signUpButton.layer.applyShadow(
            color: Color.blazeOrange,
            alpha: 0.5,
            x: 0,
            y: 5,
            blur: 20,
            spread: -20
        )
        
        signInCaption.text = "Already a member?"
        signInCaption.textColor = Color.dustyGray
        signInCaption.font = .systemFont(ofSize: 14, weight: .regular)
        
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(Color.blazeOrange, for: .normal)
        signInButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
    }
    
    @objc func test() {
        let test = UIViewController()
        test.view.backgroundColor = .white
        navigationController?.pushViewController(test, animated: true)
    }
    
    private func bindViewModel() {
        signInButton.reactive.tap
            .bind(to: viewModel.signInTrigger)
    }
}
