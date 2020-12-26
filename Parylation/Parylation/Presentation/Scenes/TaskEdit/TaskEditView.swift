//
// 
//  TaskEditView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 26.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import RxCocoa
import RxSwift
import UIKit

final class TaskEditView: UIViewController {
    var viewModel: TaskEditViewModel!

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let iconBackgroundView = UIView()
    private let iconImageView = UIImageView()

    private let taskTitleCaptionLabel = UILabel()
    private let taskTitleTextField = UITextField()
    private let taskDescriptionCaptionLabel = UILabel()
    private let taskDescriptionTextField = UITextField()
    private let taskDateCaptionLabel = UILabel()
    private let taskDateTextField = UITextField()

    private let iconCaptionLabel = UILabel()
    private let iconContainerView = UIView() // Temp

    private let colorCaptionLabel = UILabel()
    private let colorContainerView = UIView() // Temp

    private let saveButton = UIButton()

    private let disposeBag = DisposeBag()

    override func loadView() {
        view = UIView()

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().priority(.low)
        }

        contentView.addSubview(iconBackgroundView)
        iconBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(60)
        }

        iconBackgroundView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(15)
        }

        contentView.addSubview(taskTitleCaptionLabel)
        taskTitleCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(iconBackgroundView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        contentView.addSubview(taskTitleTextField)
        taskTitleTextField.snp.makeConstraints {
            $0.top.equalTo(taskTitleCaptionLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }

        contentView.addSubview(taskDescriptionCaptionLabel)
        taskDescriptionCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(taskTitleTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        contentView.addSubview(taskDescriptionTextField)
        taskDescriptionTextField.snp.makeConstraints {
            $0.top.equalTo(taskDescriptionCaptionLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }

        contentView.addSubview(taskDateCaptionLabel)
        taskDateCaptionLabel.snp.makeConstraints {
            $0.bottom.equalTo(taskDescriptionTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        contentView.addSubview(taskDateTextField)
        taskDateTextField.snp.makeConstraints {
            $0.top.equalTo(taskDateCaptionLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }

        contentView.addSubview(iconCaptionLabel)
        iconCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(taskDateTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        contentView.addSubview(iconContainerView)
        iconContainerView.snp.makeConstraints {
            $0.top.equalTo(iconCaptionLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(129)
        }

        contentView.addSubview(colorCaptionLabel)
        colorCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(iconContainerView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        contentView.addSubview(colorContainerView)
        colorContainerView.snp.makeConstraints {
            $0.top.equalTo(colorCaptionLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }

        contentView.addSubview(saveButton)
        saveButton.snp.makeConstraints {
            $0.top.equalTo(colorContainerView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
            $0.bottom.equalToSuperview().offset(-30)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        title = L10n.taskEditPageTitle
        view.backgroundColor = Color.whisper

        iconBackgroundView.layer.cornerRadius = 15
        iconBackgroundView.backgroundColor = Color.gigas

        taskTitleCaptionLabel.text = L10n.taskEditTitle
        taskTitleCaptionLabel.font = .systemFont(ofSize: 17, weight: .semibold)

        taskTitleTextField.backgroundColor = .white
        taskTitleTextField.layer.cornerRadius = 15
        taskTitleTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 2))
        taskTitleTextField.leftViewMode = .always

        taskDescriptionCaptionLabel.text = L10n.taskEditDescription
        taskDescriptionCaptionLabel.font = .systemFont(ofSize: 17, weight: .semibold)

        taskDescriptionTextField.backgroundColor = .white
        taskDescriptionTextField.layer.cornerRadius = 15
        taskDescriptionTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 2))
        taskDescriptionTextField.leftViewMode = .always

        taskDateCaptionLabel.text = L10n.taskEditDate
        taskDateCaptionLabel.font = .systemFont(ofSize: 17, weight: .semibold)

        taskDateTextField.backgroundColor = .white
        taskDateTextField.layer.cornerRadius = 15
        taskDateTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 2))
        taskDateTextField.leftViewMode = .always

        iconCaptionLabel.text = L10n.taskEditIcon
        iconCaptionLabel.font = .systemFont(ofSize: 17, weight: .semibold)

        iconContainerView.backgroundColor = Color.gray

        colorCaptionLabel.text = L10n.taskEditColor
        colorCaptionLabel.font = .systemFont(ofSize: 17, weight: .semibold)

        colorContainerView.backgroundColor = Color.gray

        saveButton.layer.cornerRadius = 20
        saveButton.backgroundColor = Color.shamrock
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.setTitle(L10n.taskEditSaveButton.uppercased(), for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        if #available(iOS 13.0, *) {
            saveButton.layer.cornerCurve = .continuous
        }
        saveButton.layer.applyShadow(
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
        viewModel.state
            .drive(onNext: updateState)
            .disposed(by: disposeBag)
        taskTitleTextField.rx.text
            .compactMap { $0 }
            .bind(to: viewModel.taskTitle)
            .disposed(by: disposeBag)
        taskDescriptionTextField.rx.text
            .compactMap { $0 }
            .bind(to: viewModel.taskDescription)
            .disposed(by: disposeBag)
//        taskDateTextField.rx.text
        saveButton.rx.tap
            .bind(to: viewModel.saveTrigger)
            .disposed(by: disposeBag)
    }

    private func updateState(_ state: TaskEditViewState) {
        switch state {
        case .ready:
            break
        case .loading:
            break
        case .display(let info):
            taskTitleTextField.text = info.title
            taskDescriptionTextField.text = info.taskDescription
            taskDateTextField.text = info.date.debugDescription
        }
    }
}
