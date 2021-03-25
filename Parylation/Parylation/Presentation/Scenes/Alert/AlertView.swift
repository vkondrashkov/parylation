//
// 
//  AlertView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import RxCocoa
import RxSwift
import UIKit

final class AlertView: UIViewController {
    var viewModel: AlertViewModel!

    private let maskView = UIView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let containerView = UIView()
    private let contentContainerView = UIStackView()
    private let actionsContainerView = UIStackView()

    private let disposeBag = DisposeBag()

    override func loadView() {
        view = UIView()

        view.addSubview(maskView)
        maskView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        maskView.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().priority(.low)
        }

        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            let containerMargin = Sizes.value(from: [.iPhone5s: 12], defaultValue: 15)
            $0.top.greaterThanOrEqualToSuperview().inset(containerMargin)
            $0.bottom.lessThanOrEqualToSuperview().inset(containerMargin)
            $0.leading.trailing.equalToSuperview().inset(containerMargin)
            $0.centerY.equalToSuperview()
        }

        containerView.addSubview(contentContainerView)
        contentContainerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(StyleGuide.Screen.margins)
        }

        containerView.addSubview(actionsContainerView)
        actionsContainerView.snp.makeConstraints {
            $0.top.equalTo(contentContainerView.snp.bottom).offset(30)
            $0.leading.trailing.bottom.equalToSuperview().inset(StyleGuide.Screen.margins)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        maskView.backgroundColor = UIColor.black.withAlphaComponent(0.3)

        scrollView.showsHorizontalScrollIndicator = false

        containerView.backgroundColor = Color.whisper
        containerView.layer.cornerRadius = 20

        contentContainerView.alignment = .fill
        contentContainerView.axis = .vertical
        contentContainerView.distribution = .fill
        contentContainerView.spacing = 10

        actionsContainerView.alignment = .fill
        actionsContainerView.axis = .horizontal
        actionsContainerView.distribution = .fillEqually
        actionsContainerView.spacing = 10
    }

    private func bindViewModel() {
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] notification in
                guard let self = self else { return }
                let userInfo = notification.userInfo ?? [:]
                let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
                self.scrollView.snp.remakeConstraints {
                    $0.top.leading.trailing.equalToSuperview()
                    $0.bottom.equalToSuperview().offset(-keyboardFrame.height)
                }
                UIView.animate(
                    withDuration: 0.25,
                    animations: {
                        self.view.layoutIfNeeded()
                    }
                )
            })
            .disposed(by: disposeBag)
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.scrollView.snp.remakeConstraints {
                    $0.edges.equalToSuperview()
                }
                UIView.animate(
                    withDuration: 0.25,
                    animations: {
                        self.view.layoutIfNeeded()
                    }
                )
            })
            .disposed(by: disposeBag)
        viewModel.info
            .drive(onNext: { [weak self] info in
                self?.buildContent(info.content)
                self?.buildActions(info.actions)
            })
            .disposed(by: disposeBag)

        let terminateGesture = UITapGestureRecognizer()
        maskView.addGestureRecognizer(terminateGesture)
        terminateGesture.rx.event
            .map { _ in () }
            .do(onNext: { [weak self] in self?.hideKeyboard() })
            .bind(to: viewModel.terminateTrigger)
            .disposed(by: disposeBag)

        let keyboardGesture = UITapGestureRecognizer()
        containerView.addGestureRecognizer(keyboardGesture)
        keyboardGesture.rx.event
            .map { _ in () }
            .subscribe(onNext: { [weak self] in self?.hideKeyboard() })
            .disposed(by: disposeBag)
    }

    private func buildContent(_ content: [AlertViewInfoItem]) {
        contentContainerView.arrangedSubviews.forEach {
            contentContainerView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        content.forEach { item in
            let itemView: UIView
            switch item {
            case .action:
                debugPrint("⛔️ Actions shouldn't be placed inside Content!")
                itemView = UIView()
            case .text(let text):
                itemView = buildText(text)
            case .textField(let textProvider, let textConsumer):
                itemView = buildTextField(textProvider, textConsumer)
            case .title(let title):
                itemView = buildTitle(title)
            case .toggle(let switchProvider, let switchConsumer):
                itemView = buildToggle(switchProvider, switchConsumer)
            case .combined:
                itemView = UIView() // TODO
            }
            contentContainerView.addArrangedSubview(itemView)
        }
    }

    private func buildTitle(_ text: String) -> UIView {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(
            ofSize: StyleGuide.Header.subtitleFontSize,
            weight: .semibold
        )
        titleLabel.text = text
        return titleLabel
    }

    private func buildText(_ text: String) -> UIView {
        let textLabel = UILabel()
        textLabel.textAlignment = .justified
        textLabel.font = .systemFont(ofSize: StyleGuide.Label.fontSize)
        textLabel.numberOfLines = 0
        textLabel.text = text
        return textLabel
    }

    private func buildToggle(_ switchProvider: @escaping () -> Bool, _ switchConsumer: @escaping (Bool) -> Void) -> UIView {
        return UISwitch()
    }

    private func buildTextField(_ textProvider: @escaping () -> String, _ textConsumer: @escaping (String) -> Void) -> UIView {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = StyleGuide.TextField.cornerRadius
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 2))
        textField.leftViewMode = .always
        textField.text = textProvider()
        textField.rx.text
            .subscribe(onNext: { textConsumer($0 ?? "") })
            .disposed(by: disposeBag)
        textField.snp.makeConstraints {
            $0.height.equalTo(StyleGuide.TextField.height)
        }
        return textField
    }

    private func buildActions(_ actions: [AlertViewInfo.ActionInfo]) {
        actionsContainerView.arrangedSubviews.forEach {
            actionsContainerView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        actions.forEach { action in
            let button = ClosureButton()
            button.snp.makeConstraints {
                $0.height.equalTo(StyleGuide.Button.height)
            }
            button.backgroundColor = action.color
            button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
            button.setTitle(action.name.uppercased(), for: .normal)
            button.layer.cornerRadius = StyleGuide.Button.cornerRadius
            if #available(iOS 13.0, *) {
                button.layer.cornerCurve = .continuous
            }
            button.layer.applyShadow(
                color: action.color,
                alpha: 0.5,
                x: 0,
                y: 5,
                blur: 20,
                spread: -20
            )
            button.didTouchUpInside = { [weak self] in
                self?.viewModel.terminateTrigger.onNext(())
                action.action?()
            }
            actionsContainerView.addArrangedSubview(button)
        }
    }

    private func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - SelfDisplayable implementation

extension AlertView: SelfDisplayable {
    @objc func selfDisplay() {
        viewModel.showTrigger.onNext(())
    }
}
