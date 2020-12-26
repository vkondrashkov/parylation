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

    override func loadView() {
        view = UIView()

        view.addSubview(iconBackgroundView)
        iconBackgroundView.snp.makeConstraints {
            $0.leading.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.size.equalTo(60)
        }

        iconBackgroundView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(15)
        }

        view.addSubview(taskTitleLabel)
        taskTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconBackgroundView.snp.trailing).offset(15)
            $0.centerY.equalTo(iconBackgroundView)
            $0.trailing.equalToSuperview().offset(-20)
        }

        view.addSubview(descriptionCaptionLabel)
        descriptionCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(iconBackgroundView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionCaptionLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        view.addSubview(dateCaptionLabel)
        dateCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(dateCaptionLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        view.addSubview(deleteButton)
        deleteButton.snp.makeConstraints {
            $0.bottom.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.size.equalTo(60)
        }

        view.addSubview(completeButton)
        completeButton.snp.makeConstraints {
            $0.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.size.equalTo(60)
        }

        view.addSubview(editButton)
        editButton.snp.makeConstraints {
            $0.leading.equalTo(deleteButton.snp.trailing).offset(20)
            $0.trailing.equalTo(completeButton.snp.leading).offset(-20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(60)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        title = "Task"
        view.backgroundColor = Color.whisper

        iconBackgroundView.backgroundColor = Color.gigas
        iconBackgroundView.layer.cornerRadius = 15
        if #available(iOS 13.0, *) {
            iconBackgroundView.layer.cornerCurve = .continuous
        }

        taskTitleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        taskTitleLabel.numberOfLines = 2

        descriptionCaptionLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        descriptionCaptionLabel.text = "Description"

        descriptionLabel.font = .systemFont(ofSize: 17)
        descriptionLabel.textAlignment = .justified
        descriptionLabel.numberOfLines = 0

        dateCaptionLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        dateCaptionLabel.text = "Date"

        dateLabel.font = .systemFont(ofSize: 17)

        deleteButton.layer.cornerRadius = 20
        deleteButton.backgroundColor = Color.blazeOrange
        deleteButton.setTitleColor(.white, for: .normal)
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

        editButton.layer.cornerRadius = 20
        editButton.backgroundColor = Color.gigas
        editButton.setTitleColor(.white, for: .normal)
        editButton.setTitle("EDIT", for: .normal)
        editButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
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

        completeButton.layer.cornerRadius = 20
        completeButton.backgroundColor = Color.shamrock
        completeButton.setTitleColor(.white, for: .normal)
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
            taskTitleLabel.text = info.title
            descriptionLabel.text = info.taskDescription
            dateLabel.text = info.date
        }
    }
}
