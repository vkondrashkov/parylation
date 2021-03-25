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

    private let closeButton = UIButton()

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

    private let labelOffset: CGFloat = Sizes.value(from: [.iPhone5s: 16], defaultValue: 20)
    private let textFieldOffset: CGFloat = Sizes.value(from: [.iPhone5s: 10], defaultValue: 15)

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
            $0.size.equalTo(StyleGuide.Button.height)
        }

        iconBackgroundView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(StyleGuide.Button.height / 2)
        }

        contentView.addSubview(taskTitleCaptionLabel)
        taskTitleCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(iconBackgroundView.snp.bottom).offset(labelOffset)
            $0.leading.trailing.equalToSuperview().inset(StyleGuide.Screen.margins)
        }

        contentView.addSubview(taskTitleTextField)
        taskTitleTextField.snp.makeConstraints {
            $0.top.equalTo(taskTitleCaptionLabel.snp.bottom).offset(textFieldOffset)
            $0.leading.trailing.equalToSuperview().inset(StyleGuide.Screen.margins)
            $0.height.equalTo(StyleGuide.TextField.height)
        }

        contentView.addSubview(taskDescriptionCaptionLabel)
        taskDescriptionCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(taskTitleTextField.snp.bottom).offset(labelOffset)
            $0.leading.trailing.equalToSuperview().inset(StyleGuide.Screen.margins)
        }

        contentView.addSubview(taskDescriptionTextField)
        taskDescriptionTextField.snp.makeConstraints {
            $0.top.equalTo(taskDescriptionCaptionLabel.snp.bottom).offset(textFieldOffset)
            $0.leading.trailing.equalToSuperview().inset(StyleGuide.Screen.margins)
            $0.height.equalTo(StyleGuide.TextField.height)
        }

        contentView.addSubview(taskDateCaptionLabel)
        taskDateCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(taskDescriptionTextField.snp.bottom).offset(labelOffset)
            $0.leading.trailing.equalToSuperview().inset(StyleGuide.Screen.margins)
        }

        contentView.addSubview(taskDateTextField)
        taskDateTextField.snp.makeConstraints {
            $0.top.equalTo(taskDateCaptionLabel.snp.bottom).offset(textFieldOffset)
            $0.leading.trailing.equalToSuperview().inset(StyleGuide.Screen.margins)
            $0.height.equalTo(StyleGuide.TextField.height)
        }

        contentView.addSubview(iconCaptionLabel)
        iconCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(taskDateTextField.snp.bottom).offset(labelOffset)
            $0.leading.trailing.equalToSuperview().inset(StyleGuide.Screen.margins)
        }

        contentView.addSubview(iconSelectionCollectionView)
        iconSelectionCollectionView.snp.makeConstraints {
            $0.top.equalTo(iconCaptionLabel.snp.bottom).offset(textFieldOffset)
            $0.leading.trailing.equalToSuperview().inset(StyleGuide.Screen.margins)
        }

        contentView.addSubview(colorCaptionLabel)
        colorCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(iconSelectionCollectionView.snp.bottom).offset(labelOffset)
            $0.leading.trailing.equalToSuperview().inset(StyleGuide.Screen.margins)
        }

        contentView.addSubview(colorSelectiveCollectionView)
        colorSelectiveCollectionView.snp.makeConstraints {
            $0.top.equalTo(colorCaptionLabel.snp.bottom).offset(textFieldOffset)
            $0.leading.trailing.equalToSuperview().inset(StyleGuide.Screen.margins)
        }

        contentView.addSubview(saveButton)
        saveButton.snp.makeConstraints {
            $0.top.equalTo(colorSelectiveCollectionView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(StyleGuide.Screen.margins + 10)
            $0.height.equalTo(StyleGuide.Button.height)
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

        iconBackgroundView.layer.cornerRadius = Sizes.value(from: [.iPhone5s: 12], defaultValue: 15)

        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white

        taskTitleCaptionLabel.text = L10n.taskEditTitle
        taskTitleCaptionLabel.font = .systemFont(
            ofSize: StyleGuide.Label.fontSize,
            weight: .semibold
        )

        taskTitleTextField.backgroundColor = .white
        taskTitleTextField.layer.cornerRadius = StyleGuide.TextField.cornerRadius
        taskTitleTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 2))
        taskTitleTextField.leftViewMode = .always
        taskTitleTextField.returnKeyType = .next
        taskTitleTextField.delegate = self

        taskDescriptionCaptionLabel.text = L10n.taskEditDescription
        taskDescriptionCaptionLabel.font = .systemFont(
            ofSize: StyleGuide.Label.fontSize,
            weight: .semibold
        )

        taskDescriptionTextField.backgroundColor = .white
        taskDescriptionTextField.layer.cornerRadius = StyleGuide.TextField.cornerRadius
        taskDescriptionTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 2))
        taskDescriptionTextField.leftViewMode = .always
        taskDescriptionTextField.returnKeyType = .next
        taskDescriptionTextField.delegate = self

        taskDateCaptionLabel.text = L10n.taskEditDate
        taskDateCaptionLabel.font = .systemFont(
            ofSize: StyleGuide.Label.fontSize,
            weight: .semibold
        )

        taskDateTextField.backgroundColor = .white
        taskDateTextField.layer.cornerRadius = StyleGuide.TextField.cornerRadius
        taskDateTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 2))
        taskDateTextField.leftViewMode = .always
        taskDateTextField.inputAccessoryView = toolBar
        taskDateTextField.inputView = datePicker
        taskDateTextField.returnKeyType = .done
        taskDateTextField.delegate = self

        datePicker.datePickerMode = .dateAndTime
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }

        iconCaptionLabel.text = L10n.taskEditIcon
        iconCaptionLabel.font = .systemFont(
            ofSize: StyleGuide.Label.fontSize,
            weight: .semibold
        )

        colorCaptionLabel.text = L10n.taskEditColor
        colorCaptionLabel.font = .systemFont(
            ofSize: StyleGuide.Label.fontSize,
            weight: .semibold
        )

        saveButton.layer.cornerRadius = StyleGuide.Button.cornerRadius
        saveButton.backgroundColor = Color.shamrock
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.setTitle(L10n.taskEditSaveButton.uppercased(), for: .normal)
        saveButton.titleLabel?.font = .systemFont(
            ofSize: StyleGuide.Button.fontSize,
            weight: .semibold
        )
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
        let tapGesture = UITapGestureRecognizer()
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        tapGesture.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
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
                    $0.edges.equalToSuperview().priority(.high)
                }
                UIView.animate(
                    withDuration: 0.25,
                    animations: {
                        self.view.layoutIfNeeded()
                    }
                )
            })
            .disposed(by: disposeBag)

        viewModel.icons
            .drive(iconSelectionCollectionView.rx.items(cellIdentifier: SelectiveIconCollectionViewCell.reuseId)) { [weak self] row, item, cell in
                let iconCell = cell as? SelectiveIconCollectionViewCell
                if item.image == self?.iconImageView.image {
                    cell.isSelected = true
                    self?.viewModel.iconSelectionTrigger.onNext(IndexPath(row: row, section: 0))
                }
                iconCell?.iconImageView.image = item.image
            }
            .disposed(by: disposeBag)

        viewModel.colors
            .drive(colorSelectiveCollectionView.rx.items(cellIdentifier: SelectiveColorCollectionViewCell.reuseId, cellType: SelectiveColorCollectionViewCell.self)) { [weak self] row, item, cell in
                if item.value == self?.iconBackgroundView.backgroundColor {
                    cell.isSelected = true
                    self?.viewModel.colorSelectionTrigger.onNext(IndexPath(row: row, section: 0))
                }
                cell.color = item.value
            }
            .disposed(by: disposeBag)

        iconSelectionCollectionView.rx.itemSelected
            .do(onNext: { [weak self] indexPath in
                self?.iconSelectionCollectionView.visibleCells
                    .forEach { $0.isSelected = false }
            })
            .bind(to: viewModel.iconSelectionTrigger)
            .disposed(by: disposeBag)

        colorSelectiveCollectionView.rx.itemSelected
            .do(onNext: { [weak self] indexPath in
                self?.colorSelectiveCollectionView.visibleCells
                    .forEach { $0.isSelected = false }
            })
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
            viewModel.iconSelectionTrigger.onNext(IndexPath(row: 0, section: 0))
            viewModel.colorSelectionTrigger.onNext(IndexPath(row: 0, section: 0))
        case .loading:
            break
        case .display(let info):
            iconImageView.image = info.image
            iconBackgroundView.backgroundColor = info.color
            taskTitleTextField.text = info.title
            if let title = info.title {
                viewModel.taskTitle.onNext(title)
            }
            taskDescriptionTextField.text = info.taskDescription
            if let description = info.taskDescription {
                viewModel.taskDescription.onNext(description)
            }
            if let date = info.date {
                viewModel.taskDate.onNext(date)
                taskDateTextField.text = CommonTextFormatter().dateToString(date)
                datePicker.date = date
            }
        }
    }

    @objc private func doneButtonDidTap() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate implementation

extension TaskEditView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === taskTitleTextField {
            taskDescriptionTextField.becomeFirstResponder()
        } else if textField === taskDescriptionTextField {
            taskDateTextField.becomeFirstResponder()
        } else if textField === taskDateTextField {
            view.endEditing(true)
        }
        return true
    }
}
