//
//  SignUpView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class SignUpView: UIViewController {
    var viewModel: SignUpViewModel!
    
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    private let emailCaptionLabel = UILabel()
    private let emailErrorLabel = UILabel()
    private let emailTextField = UITextField()

    private let passwordCaptionLabel = UILabel()
    private let passwordErrorLabel = UILabel()
    private let passwordTextField = UITextField()

    private let confirmPasswordCaptionLabel = UILabel()
    private let confirmPasswordErrorLabel = UILabel()
    private let confirmPasswordTextField = UITextField()

    private let signUpButton = UIButton()
    private let signInCaption = UILabel()
    private let signInButton = UIButton()

    private let disposeBag = DisposeBag()

    private let labelOffset: CGFloat = Sizes.value(from: [.iPhone5s: 18], defaultValue: 25)
    private let textFieldOffset: CGFloat = Sizes.value(from: [.iPhone5s: 10], defaultValue: 15)
    private let errorLabelSize: CGFloat = Sizes.value(from: [.iPhone5s: 12], defaultValue: 14)
    
    override func loadView() {
        view = UIView()
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
            $0.top.greaterThanOrEqualToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
            $0.leading.trailing.equalToSuperview().inset(StyleGuide.Screen.margins)
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
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(
                Sizes.value(from: [.iPhone5s: 25], defaultValue: 30)
            )
            $0.leading.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }

        contentView.addSubview(emailErrorLabel)
        emailErrorLabel.snp.makeConstraints {
            $0.centerY.equalTo(emailCaptionLabel)
            $0.trailing.equalToSuperview()
        }
        
        contentView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailCaptionLabel.snp.bottom).offset(textFieldOffset)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(StyleGuide.TextField.height)
        }
        
        contentView.addSubview(passwordCaptionLabel)
        passwordCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(labelOffset)
            $0.leading.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }

        contentView.addSubview(passwordErrorLabel)
        passwordErrorLabel.snp.makeConstraints {
            $0.centerY.equalTo(passwordCaptionLabel)
            $0.trailing.equalToSuperview()
        }
        
        contentView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordCaptionLabel.snp.bottom).offset(textFieldOffset)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(StyleGuide.TextField.height)
        }
        
        contentView.addSubview(confirmPasswordCaptionLabel)
        confirmPasswordCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(labelOffset)
            $0.leading.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }

        contentView.addSubview(confirmPasswordErrorLabel)
        confirmPasswordErrorLabel.snp.makeConstraints {
            $0.centerY.equalTo(confirmPasswordCaptionLabel)
            $0.trailing.equalToSuperview()
        }
        
        contentView.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordCaptionLabel.snp.bottom).offset(textFieldOffset)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(StyleGuide.TextField.height)
        }
        
        contentView.addSubview(signUpButton)
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordTextField.snp.bottom).offset(
                Sizes.value(from: [.iPhone5s: 25], defaultValue: 30)
            )
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(StyleGuide.TextField.height)
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
        
        titleLabel.font = .systemFont(ofSize: Sizes.value(from: [.iPhone5s: 48], defaultValue: 56))
        titleLabel.text = "🤝"
        
        subtitleLabel.font = .systemFont(
            ofSize: Sizes.value(from: [.iPhone5s: 20], defaultValue: 24),
            weight: .ultraLight
        )
        subtitleLabel.text = L10n.signUpSubtitle
        subtitleLabel.numberOfLines = 2
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .black
        
        emailCaptionLabel.font = .systemFont(
            ofSize: StyleGuide.Label.fontSize,
            weight: .semibold
        )
        emailCaptionLabel.text = L10n.signUpEmail
        emailCaptionLabel.textColor = .black

        emailErrorLabel.font = .systemFont(ofSize: errorLabelSize, weight: .semibold)
        emailErrorLabel.textColor = Color.monza
        emailErrorLabel.textAlignment = .right
        
        emailTextField.backgroundColor = .white
        emailTextField.layer.cornerRadius = StyleGuide.TextField.cornerRadius
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 2))
        emailTextField.leftViewMode = .always
        emailTextField.placeholder = "example@domain.com"
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocorrectionType = .no
        emailTextField.textContentType = .emailAddress
        emailTextField.autocapitalizationType = .none
        
        passwordCaptionLabel.font = .systemFont(
            ofSize: StyleGuide.Label.fontSize,
            weight: .semibold
        )
        passwordCaptionLabel.text = L10n.signUpPassword
        passwordCaptionLabel.textColor = .black

        passwordErrorLabel.font = .systemFont(ofSize: errorLabelSize, weight: .semibold)
        passwordErrorLabel.textColor = Color.monza
        passwordErrorLabel.textAlignment = .right
        
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = StyleGuide.TextField.cornerRadius
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 2))
        passwordTextField.leftViewMode = .always
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .password
        
        confirmPasswordCaptionLabel.font = .systemFont(
            ofSize: StyleGuide.Label.fontSize,
            weight: .semibold
        )
        confirmPasswordCaptionLabel.text = L10n.signUpConfirmPassword
        confirmPasswordCaptionLabel.textColor = .black

        confirmPasswordErrorLabel.font = .systemFont(ofSize: errorLabelSize, weight: .semibold)
        confirmPasswordErrorLabel.textColor = Color.monza
        confirmPasswordErrorLabel.textAlignment = .right
        
        confirmPasswordTextField.backgroundColor = .white
        confirmPasswordTextField.layer.cornerRadius = StyleGuide.TextField.cornerRadius
        confirmPasswordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 2))
        confirmPasswordTextField.leftViewMode = .always
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.textContentType = .password
        
        signUpButton.setTitle(L10n.signUpButton.uppercased(), for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = Color.gigas
        signUpButton.layer.cornerRadius = 20
        if #available(iOS 13.0, *) {
            signUpButton.layer.cornerCurve = .continuous
        }
        signUpButton.titleLabel?.font = .systemFont(
            ofSize: StyleGuide.Button.fontSize,
            weight: .semibold
        )
        signUpButton.layer.applyShadow(
            color: Color.gigas,
            alpha: 0.5,
            x: 0,
            y: 5,
            blur: 20,
            spread: -20
        )
        
        signInCaption.text = L10n.signUpSignInCaption
        signInCaption.textColor = Color.dustyGray
        signInCaption.font = .systemFont(
            ofSize: StyleGuide.Button.fontSize,
            weight: .regular
        )
        
        signInButton.setTitle(L10n.signUpSignIn, for: .normal)
        signInButton.setTitleColor(Color.gigas, for: .normal)
        signInButton.titleLabel?.font = .systemFont(
            ofSize: StyleGuide.Button.fontSize,
            weight: .bold
        )
    }
    
    private func bindViewModel() {
        emailTextField.rx.text
            .compactMap { $0 }
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)

        passwordTextField.rx.text
            .compactMap { $0 }
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)

        confirmPasswordTextField.rx.text
            .compactMap { $0 }
            .bind(to: viewModel.confirmPassword)
            .disposed(by: disposeBag)

        signUpButton.rx.tap
            .bind(to: viewModel.signUpTrigger)
            .disposed(by: disposeBag)
        
        signInButton.rx.tap
            .bind(to: viewModel.signInTrigger)
            .disposed(by: disposeBag)

        viewModel.emailError
            .drive(emailErrorLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.passwordError
            .drive(passwordErrorLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.confirmPasswordError
            .drive(confirmPasswordErrorLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
