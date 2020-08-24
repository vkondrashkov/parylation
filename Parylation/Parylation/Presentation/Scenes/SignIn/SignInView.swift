//
//  SignInView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit
import UIKit

final class SignInView: UIViewController {
    var viewModel: SignInViewModel!
    
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let emailCaptionLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordCaptionLabel = UILabel()
    private let passwordTextField = UITextField()
    private let forgotPasswordButton = UIButton()
    private let signInButton = UIButton()
    private let signUpCaption = UILabel()
    private let signUpButton = UIButton()
    
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
        
        contentView.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(15)
            $0.leading.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        contentView.addSubview(signInButton)
        signInButton.snp.makeConstraints {
            $0.top.equalTo(forgotPasswordButton.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        let signUpView = UIView()
        contentView.addSubview(signUpView)
        signUpView.snp.makeConstraints {
            $0.top.equalTo(signInButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        signUpView.addSubview(signUpCaption)
        signUpCaption.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
        
        signUpView.addSubview(signUpButton)
        signUpButton.snp.makeConstraints {
            $0.leading.equalTo(signUpCaption.snp.trailing).offset(5)
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
        
        titleLabel.font = .systemFont(ofSize: 48)
        titleLabel.text = "👋"
        
        subtitleLabel.font = .systemFont(ofSize: 24, weight: .ultraLight)
        subtitleLabel.text = "Great to see you again!" // localize
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
        
        forgotPasswordButton.setTitle("Forgot your password?", for: .normal)
        forgotPasswordButton.setTitleColor(Color.blazeOrange, for: .normal)
        forgotPasswordButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        
        signInButton.setTitle("SIGN IN", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.backgroundColor = Color.blazeOrange
        signInButton.layer.cornerRadius = 20
        if #available(iOS 13.0, *) {
            signInButton.layer.cornerCurve = .continuous
        }
        signInButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        signInButton.layer.applyShadow(
            color: Color.blazeOrange,
            alpha: 0.5,
            x: 0,
            y: 5,
            blur: 20,
            spread: -20
        )
        
        signUpCaption.text = "No account yet?"
        signUpCaption.textColor = Color.dustyGray
        signUpCaption.font = .systemFont(ofSize: 14, weight: .regular)
        
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(Color.blazeOrange, for: .normal)
        signUpButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
    }
    
    @objc func test() {
        let test = UIViewController()
        test.view.backgroundColor = .white
        navigationController?.pushViewController(test, animated: true)
    }
    
    private func bindViewModel() {
        signInButton.reactive.tap
            .bind(to: viewModel.signInTrigger)
        
        signUpButton.reactive.tap
            .bind(to: viewModel.signUpTrigger)
    }
}
