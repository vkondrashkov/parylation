//
// 
//  CalendarView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 27.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//
//

import RxCocoa
import RxSwift
import UIKit

final class CalendarView: UIViewController {
    var viewModel: CalendarViewModel!

    private let headerTitleLabel = UILabel()
    private let headerSubtitleLabel = UILabel()

    private let previousMonthButton = UIButton()
    private let currentMonthLabel = UILabel()
    private let nextMonthButton = UIButton()

    private let weekdaysStackView = UIStackView()

    private let monthCollectionViewLayout = UICollectionViewFlowLayout()
    private lazy var monthCollectionView = UICollectionView(frame: .zero, collectionViewLayout: monthCollectionViewLayout)

    private let createButton = UIButton()

    private let disposeBag = DisposeBag()

    override func loadView() {
        view = UIView()

        view.addSubview(headerTitleLabel)
        headerTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(
                StyleGuide.Header.margins
            ).priority(.high)
        }

        view.addSubview(headerSubtitleLabel)
        headerSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(headerTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(
                StyleGuide.Header.margins
            ).priority(.high)
        }

        let monthHeaderContainerView = UIView()
        view.addSubview(monthHeaderContainerView)
        monthHeaderContainerView.snp.makeConstraints {
            $0.top.equalTo(headerSubtitleLabel.snp.bottom).offset(
                Sizes.value(from: [.iPhone5s: 30], defaultValue: 70)
            )
            $0.leading.trailing.equalToSuperview().inset(
                StyleGuide.Header.margins
            ).priority(.high)
        }

        monthHeaderContainerView.addSubview(previousMonthButton)
        previousMonthButton.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.top.leading.bottom.equalToSuperview()
        }

        monthHeaderContainerView.addSubview(currentMonthLabel)
        currentMonthLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.greaterThanOrEqualToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }

        monthHeaderContainerView.addSubview(nextMonthButton)
        nextMonthButton.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.top.trailing.bottom.equalToSuperview()
        }

        view.addSubview(weekdaysStackView)
        weekdaysStackView.snp.makeConstraints {
            $0.top.equalTo(monthHeaderContainerView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(
                StyleGuide.Screen.margins
            ).priority(.high)
        }

        view.addSubview(monthCollectionView)
        monthCollectionView.snp.makeConstraints {
            $0.top.equalTo(weekdaysStackView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(
                StyleGuide.Screen.margins
            ).priority(.high)
            $0.height.equalTo(270)
        }

        view.addSubview(createButton)
        createButton.snp.makeConstraints {
            $0.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.size.equalTo(StyleGuide.Button.height)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        view.backgroundColor = .white

        headerTitleLabel.font = .systemFont(
            ofSize: StyleGuide.Header.titleFontSize,
            weight: .heavy
        )
        headerTitleLabel.text = L10n.calendarTitle
        headerTitleLabel.textColor = Color.gigas

        headerSubtitleLabel.font = .systemFont(
            ofSize: StyleGuide.Header.subtitleFontSize,
            weight: .ultraLight
        )
        let subtitleText = L10n.calendarSubtitle
        let accent = L10n.calendarSubtitleAccent
        let headerSubtitleText = NSMutableAttributedString(
            string: subtitleText + accent,
            attributes: [
                .font: UIFont.systemFont(
                    ofSize: StyleGuide.Header.subtitleFontSize,
                    weight: .ultraLight
                )
            ]
        )
        headerSubtitleText.addAttributes([
            .font: UIFont.systemFont(
                ofSize: StyleGuide.Header.subtitleFontSize,
                weight: .semibold
            )
        ], range: NSRange(location: subtitleText.count, length: accent.count))
        headerSubtitleLabel.attributedText = headerSubtitleText
        headerSubtitleLabel.textColor = .black

        previousMonthButton.backgroundColor = Color.gigas
        previousMonthButton.layer.cornerRadius = 15
        previousMonthButton.setImage(Asset.calendarArrowLeft.image, for: .normal)

        currentMonthLabel.font = .systemFont(
            ofSize: StyleGuide.Label.fontSize,
            weight: .bold
        )

        nextMonthButton.backgroundColor = Color.gigas
        nextMonthButton.layer.cornerRadius = 15
        nextMonthButton.setImage(Asset.calendarArrowRight.image, for: .normal)

        weekdaysStackView.alignment = .center
        weekdaysStackView.axis = .horizontal
        weekdaysStackView.distribution = .fillEqually

        monthCollectionViewLayout.minimumLineSpacing = 0
        monthCollectionViewLayout.minimumInteritemSpacing = 0

        monthCollectionView.backgroundColor = .clear
        monthCollectionView.isScrollEnabled = false
        monthCollectionView.delegate = self
        monthCollectionView.register(CalendarDateCollectionViewCell.self)

        createButton.layer.cornerRadius = StyleGuide.Button.height / 2
        createButton.backgroundColor = Color.marigoldYellow
        createButton.setImage(Asset.commonTaskPlus.image, for: .normal)
    }

    private func bindViewModel() {
        rx.methodInvoked(#selector(UIViewController.viewWillAppear))
            .map { _ in Date() }
            .bind(to: viewModel.daySelectionTrigger)
            .disposed(by: disposeBag)

        previousMonthButton.rx.tap
            .bind(to: viewModel.previousMonthTrigger)
            .disposed(by: disposeBag)

        nextMonthButton.rx.tap
            .bind(to: viewModel.nextMonthTrigger)
            .disposed(by: disposeBag)

        createButton.rx.tap
            .bind(to: viewModel.createTrigger)
            .disposed(by: disposeBag)

        viewModel.selectedMonth
            .drive(currentMonthLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.weekDays
            .drive(onNext: updateWeekdays)
            .disposed(by: disposeBag)

        viewModel.days
            .drive(monthCollectionView.rx.items(cellIdentifier: CalendarDateCollectionViewCell.reuseId, cellType: CalendarDateCollectionViewCell.self)) { index, item, cell in
                cell.day = item
            }
            .disposed(by: disposeBag)

        monthCollectionView.rx.itemSelected
            .bind(to: viewModel.selectTrigger)
            .disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func updateWeekdays(items: [String]) {
        for subview in weekdaysStackView.arrangedSubviews {
            weekdaysStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }

        for item in items {
            let weekdayLabel = UILabel()
            weekdayLabel.text = item
            weekdayLabel.font = .systemFont(ofSize: 14, weight: .ultraLight)
            weekdayLabel.textAlignment = .center
            weekdaysStackView.addArrangedSubview(weekdayLabel)
        }
    }
}

extension CalendarView: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {

  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let cellSize: CGFloat = Sizes.value(from: [.iPhone5s: 40], defaultValue: 45)
    return CGSize(width: cellSize, height: cellSize)
  }
}
