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
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
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

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(20)
        }

        contentView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        contentView.addSubview(actionsContainerView)
        actionsContainerView.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(30)
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

        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20

        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 24, weight: .semibold)

        messageLabel.textAlignment = .justified
        messageLabel.font = .systemFont(ofSize: 17)
        messageLabel.numberOfLines = 0

        actionsContainerView.alignment = .fill
        actionsContainerView.axis = .horizontal
        actionsContainerView.distribution = .fillProportionally
        actionsContainerView.spacing = 10
    }

    private func bindViewModel() {
        viewModel.info
            .drive(onNext: { [weak self] info in
                self?.titleLabel.text = info.title
                self?.messageLabel.text = info.message
                self?.buildActions(info.actions)
            })
            .disposed(by: disposeBag)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        view.addGestureRecognizer(tapGesture)
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
