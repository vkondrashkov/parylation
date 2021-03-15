//
// 
//  TaskView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import RxCocoa
import RxSwift
import UIKit

final class TaskView: UIViewController {
    var viewModel: TaskViewModel!

    private let iconBackgroundView = UIView()
    private let iconImageView = UIImageView()
    private let taskTitleLabel = UILabel()

    private let descriptionCaptionLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dateCaptionLabel = UILabel()
    private let dateLabel = UILabel()

    private let deleteButton = UIButton()
    private let editButton = UIButton()
    private let completeButton = UIButton()

    private let disposeBag = DisposeBag()

    private let imagesContentInset: CGFloat = Sizes.value(from: [.iPhone5s: 12], defaultValue: 15)
    private lazy var buttonEdgeInset = UIEdgeInsets(
        top: imagesContentInset,
        left: imagesContentInset,
        bottom: imagesContentInset,
        right: imagesContentInset
    )
    private let labelOffset: CGFloat = Sizes.value(from: [.iPhone5s: 16], defaultValue: 20)
    private let textOffset: CGFloat = Sizes.value(from: [.iPhone5s: 10], defaultValue: 15)

    override func loadView() {
        view = UIView()

        view.addSubview(iconBackgroundView)
        iconBackgroundView.snp.makeConstraints {
            $0.leading.top.equalTo(view.safeAreaLayoutGuide).inset(StyleGuide.Screen.margins)
            $0.size.equalTo(StyleGuide.Button.height)
        }

        iconBackgroundView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(StyleGuide.Button.height / 2)
        }

        view.addSubview(taskTitleLabel)
        taskTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconBackgroundView.snp.trailing).offset(15)
            $0.centerY.equalTo(iconBackgroundView)
            $0.trailing.equalToSuperview().offset(-StyleGuide.Screen.margins)
        }

        view.addSubview(descriptionCaptionLabel)
        descriptionCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(iconBackgroundView.snp.bottom).offset(labelOffset)
            $0.leading.trailing.equalToSuperview().inset(StyleGuide.Screen.margins)
        }

        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionCaptionLabel.snp.bottom).offset(textOffset)
            $0.leading.trailing.equalToSuperview().inset(StyleGuide.Screen.margins)
        }

        view.addSubview(dateCaptionLabel)
        dateCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(labelOffset)
            $0.leading.trailing.equalToSuperview().inset(StyleGuide.Screen.margins)
        }

        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(dateCaptionLabel.snp.bottom).offset(textOffset)
            $0.leading.trailing.equalToSuperview().inset(StyleGuide.Screen.margins)
        }

        view.addSubview(deleteButton)
        deleteButton.snp.makeConstraints {
            $0.bottom.leading.equalTo(view.safeAreaLayoutGuide).inset(StyleGuide.Screen.margins)
            $0.size.equalTo(StyleGuide.Button.height)
        }

        view.addSubview(completeButton)
        completeButton.snp.makeConstraints {
            $0.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(StyleGuide.Screen.margins)
            $0.size.equalTo(StyleGuide.Button.height)
        }

        view.addSubview(editButton)
        editButton.snp.makeConstraints {
            $0.leading.equalTo(deleteButton.snp.trailing).offset(StyleGuide.Screen.margins)
            $0.trailing.equalTo(completeButton.snp.leading).offset(-StyleGuide.Screen.margins)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-StyleGuide.Screen.margins)
            $0.height.equalTo(StyleGuide.Button.height)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        title = L10n.taskPageTitle
        view.backgroundColor = Color.whisper

        iconBackgroundView.backgroundColor = Color.gigas
        iconBackgroundView.layer.cornerRadius = Sizes.value(from: [.iPhone5s: 12], defaultValue: 15)
        if #available(iOS 13.0, *) {
            iconBackgroundView.layer.cornerCurve = .continuous
        }

        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white

        taskTitleLabel.font = .systemFont(ofSize: StyleGuide.Header.subtitleFontSize, weight: .semibold)
        taskTitleLabel.numberOfLines = 2

        descriptionCaptionLabel.font = .systemFont(
            ofSize: StyleGuide.Label.fontSize,
            weight: .semibold
        )
        descriptionCaptionLabel.text = L10n.taskDescription

        descriptionLabel.font = .systemFont(ofSize: StyleGuide.Label.fontSize)
        descriptionLabel.textAlignment = .justified
        descriptionLabel.numberOfLines = 0

        dateCaptionLabel.font = .systemFont(
            ofSize: StyleGuide.Label.fontSize,
            weight: .semibold
        )
        dateCaptionLabel.text = L10n.taskDate

        dateLabel.font = .systemFont(ofSize: StyleGuide.Label.fontSize)

        deleteButton.layer.cornerRadius = StyleGuide.Button.cornerRadius
        deleteButton.backgroundColor = Color.blazeOrange
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.setImage(Asset.commonDelete.image.withRenderingMode(.alwaysTemplate), for: .normal)
        deleteButton.imageEdgeInsets = buttonEdgeInset
        deleteButton.tintColor = .white
        if #available(iOS 13.0, *) {
            deleteButton.layer.cornerCurve = .continuous
        }
        deleteButton.layer.applyShadow(
            color: Color.blazeOrange,
            alpha: 0.5,
            x: 0,
            y: 5,
            blur: 20,
            spread: -20
        )

        editButton.layer.cornerRadius = StyleGuide.Button.cornerRadius
        editButton.backgroundColor = Color.gigas
        editButton.setTitleColor(.white, for: .normal)
        editButton.setTitle(L10n.taskEditButton.uppercased(), for: .normal)
        editButton.titleLabel?.font = .systemFont(
            ofSize: StyleGuide.Button.fontSize,
            weight: .semibold
        )
        if #available(iOS 13.0, *) {
            editButton.layer.cornerCurve = .continuous
        }
        editButton.layer.applyShadow(
            color: Color.gigas,
            alpha: 0.5,
            x: 0,
            y: 5,
            blur: 20,
            spread: -20
        )

        completeButton.layer.cornerRadius = StyleGuide.Button.cornerRadius
        completeButton.backgroundColor = Color.shamrock
        completeButton.setTitleColor(.white, for: .normal)
        completeButton.setImage(Asset.commonConfirm.image.withRenderingMode(.alwaysTemplate), for: .normal)
        completeButton.imageEdgeInsets = buttonEdgeInset
        completeButton.tintColor = .white
        if #available(iOS 13.0, *) {
            completeButton.layer.cornerCurve = .continuous
        }
        completeButton.layer.applyShadow(
            color: Color.shamrock,
            alpha: 0.5,
            x: 0,
            y: 5,
            blur: 20,
            spread: -20
        )
    }

    private func bindViewModel() {
        rx.methodInvoked(#selector(UIViewController.viewWillAppear))
            .map { _ in () }
            .bind(to: viewModel.willAppearTrigger)
            .disposed(by: disposeBag)

        deleteButton.rx.tap
            .bind(to: viewModel.deleteTrigger)
            .disposed(by: disposeBag)

        editButton.rx.tap
            .bind(to: viewModel.editTrigger)
            .disposed(by: disposeBag)

        completeButton.rx.tap
            .bind(to: viewModel.completeTrigger)
            .disposed(by: disposeBag)

        viewModel.state
            .drive(onNext: updateState)
            .disposed(by: disposeBag)
    }

    private func updateState(_ state: TaskViewState) {
        switch state {
        case .ready:
            break
        case .loading:
            break
        case .display(let info):
            iconImageView.image = info.icon
            iconBackgroundView.backgroundColor = info.color
            taskTitleLabel.text = info.title
            descriptionLabel.text = info.taskDescription
            dateLabel.text = info.date
        }
    }
}
