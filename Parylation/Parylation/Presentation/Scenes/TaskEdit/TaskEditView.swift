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
    private let datePicker = UIDatePicker()

    private let iconCaptionLabel = UILabel()
    private let iconSelectionCollectionView = SelectiveCollectionView<SelectiveIconCollectionViewCell>(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )

    private let colorCaptionLabel = UILabel()
    private let colorSelectiveCollectionView = SelectiveCollectionView<SelectiveColorCollectionViewCell>(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )

    private let saveButton = UIButton()

    private let toolBar = UIToolbar()

    private let disposeBag = DisposeBag()

    override func loadView() {
        view = UIView()

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview().priority(.high)
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
            $0.size.equalTo(30)
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
            $0.top.equalTo(taskDescriptionTextField.snp.bottom).offset(20)
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

        contentView.addSubview(iconSelectionCollectionView)
        iconSelectionCollectionView.snp.makeConstraints {
            $0.top.equalTo(iconCaptionLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        contentView.addSubview(colorCaptionLabel)
        colorCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(iconSelectionCollectionView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        contentView.addSubview(colorSelectiveCollectionView)
        colorSelectiveCollectionView.snp.makeConstraints {
            $0.top.equalTo(colorCaptionLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        contentView.addSubview(saveButton)
        saveButton.snp.makeConstraints {
            $0.top.equalTo(colorSelectiveCollectionView.snp.bottom).offset(30)
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

        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white

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
        taskDateTextField.inputAccessoryView = toolBar
        taskDateTextField.inputView = datePicker

        datePicker.datePickerMode = .dateAndTime
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }

        iconCaptionLabel.text = L10n.taskEditIcon
        iconCaptionLabel.font = .systemFont(ofSize: 17, weight: .semibold)

        colorCaptionLabel.text = L10n.taskEditColor
        colorCaptionLabel.font = .systemFont(ofSize: 17, weight: .semibold)

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

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonDidTap))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.sizeToFit()
    }

    private func bindViewModel() {
        viewModel.icons
            .drive(iconSelectionCollectionView.rx.items(cellIdentifier: SelectiveIconCollectionViewCell.reuseId)) { row, item, cell in
                let iconCell = cell as? SelectiveIconCollectionViewCell
                iconCell?.iconImageView.image = item.image
            }
            .disposed(by: disposeBag)

        viewModel.colors
            .drive(colorSelectiveCollectionView.rx.items(cellIdentifier: SelectiveColorCollectionViewCell.reuseId, cellType: SelectiveColorCollectionViewCell.self)) { row, item, cell in
                cell.color = item.value
            }
            .disposed(by: disposeBag)

        iconSelectionCollectionView.rx.itemSelected
            .bind(to: viewModel.iconSelectionTrigger)
            .disposed(by: disposeBag)

        colorSelectiveCollectionView.rx.itemSelected
            .bind(to: viewModel.colorSelectionTrigger)
            .disposed(by: disposeBag)

        viewModel.taskIcon
            .drive(iconImageView.rx.image)
            .disposed(by: disposeBag)

        viewModel.taskColor
            .drive(iconBackgroundView.rx.backgroundColor)
            .disposed(by: disposeBag)

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
        saveButton.rx.tap
            .bind(to: viewModel.saveTrigger)
            .disposed(by: disposeBag)

        datePicker.rx.date
            .map { CommonTextFormatter().dateToString($0) }
            .bind(to: taskDateTextField.rx.text)
            .disposed(by: disposeBag)

        datePicker.rx.date
            .bind(to: viewModel.taskDate)
            .disposed(by: disposeBag)
    }

    private func updateState(_ state: TaskEditViewState) {
        switch state {
        case .ready:
            iconSelectionCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
            colorSelectiveCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
        case .loading:
            break
        case .display(let info):
            taskTitleTextField.text = info.title
            taskDescriptionTextField.text = info.taskDescription
            if let date = info.date {
                taskDateTextField.text = CommonTextFormatter().dateToString(date)
                datePicker.date = date
            }
        }
    }

    @objc private func doneButtonDidTap() {
        view.endEditing(true)
    }
}
