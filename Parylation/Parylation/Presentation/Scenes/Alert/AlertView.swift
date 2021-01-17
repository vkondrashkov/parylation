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
    private let contentView = UIView()
    private let contentContainerView = UIStackView()
    private let actionsContainerView = UIStackView()

    private let disposeBag = DisposeBag()

    override func loadView() {
        view = UIView()

        view.addSubview(maskView)
        maskView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        maskView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }

        contentView.addSubview(contentContainerView)
        contentContainerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(20)
        }

        contentView.addSubview(actionsContainerView)
        actionsContainerView.snp.makeConstraints {
            $0.top.equalTo(contentContainerView.snp.bottom).offset(30)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        maskView.backgroundColor = UIColor.black.withAlphaComponent(0.3)

        contentView.backgroundColor = Color.whisper
        contentView.layer.cornerRadius = 20

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
//        rx.methodInvoked(#selector(AlertView.selfDisplay))
//            .map { _ in () }
//            .bind(to: viewModel.showTrigger)
//            .disposed(by: disposeBag)

        viewModel.info
            .drive(onNext: { [weak self] info in
                self?.buildContent(info.content)
                self?.buildActions(info.actions)
            })
            .disposed(by: disposeBag)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        maskView.addGestureRecognizer(tapGesture)
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
            case .combined(let items):
                itemView = UIView() // TODO
            }
//            itemView.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
            contentContainerView.addArrangedSubview(itemView)
        }
    }

    private func buildTitle(_ text: String) -> UIView {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        titleLabel.text = text
        return titleLabel
    }

    private func buildText(_ text: String) -> UIView {
        let textLabel = UILabel()
        textLabel.textAlignment = .justified
        textLabel.font = .systemFont(ofSize: 17)
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
        textField.layer.cornerRadius = 15
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 2))
        textField.leftViewMode = .always
        textField.text = textProvider()
        textField.rx.text
            .subscribe(onNext: { textConsumer($0 ?? "") })
            .disposed(by: disposeBag)
        textField.snp.makeConstraints {
            $0.height.equalTo(60)
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
                $0.height.equalTo(60)
            }
            button.backgroundColor = action.color
            button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
            button.setTitle(action.name.uppercased(), for: .normal)
            button.layer.cornerRadius = 20
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

    @objc func viewDidTap() {
        viewModel.terminateTrigger.onNext(())
    }
}

// MARK: - SelfDisplayable implementation

extension AlertView: SelfDisplayable {
    @objc func selfDisplay() {
        viewModel.showTrigger.onNext(())
    }
}
