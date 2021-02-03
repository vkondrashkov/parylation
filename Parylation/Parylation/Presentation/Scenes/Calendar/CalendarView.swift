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
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.lessThanOrEqualToSuperview().offset(-30)
        }

        view.addSubview(headerSubtitleLabel)
        headerSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(headerTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.lessThanOrEqualToSuperview().offset(-30)
        }

        let monthHeaderContainerView = UIView()
        view.addSubview(monthHeaderContainerView)
        monthHeaderContainerView.snp.makeConstraints {
            $0.top.equalTo(headerSubtitleLabel.snp.bottom).offset(70)
            $0.leading.trailing.equalToSuperview().inset(30)
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
            $0.leading.trailing.equalToSuperview().inset(30)
        }

        view.addSubview(monthCollectionView)
        monthCollectionView.snp.makeConstraints {
            $0.top.equalTo(weekdaysStackView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(270)
        }

        view.addSubview(createButton)
        createButton.snp.makeConstraints {
            $0.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.size.equalTo(60)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        view.backgroundColor = .white

        headerTitleLabel.font = .systemFont(ofSize: 28, weight: .heavy)
        headerTitleLabel.text = L10n.calendarTitle
        headerTitleLabel.textColor = Color.gigas

        headerSubtitleLabel.font = .systemFont(ofSize: 24, weight: .ultraLight)
        let subtitleText = L10n.calendarSubtitle
        let accent = L10n.calendarSubtitleAccent
        let headerSubtitleText = NSMutableAttributedString(
            string: subtitleText + accent,
            attributes: [
                .font: UIFont.systemFont(ofSize: 24, weight: .ultraLight)
            ]
        )
        headerSubtitleText.addAttributes([
            .font: UIFont.systemFont(ofSize: 24, weight: .semibold)
        ], range: NSRange(location: subtitleText.count, length: accent.count))
        headerSubtitleLabel.attributedText = headerSubtitleText
        headerSubtitleLabel.textColor = .black

        previousMonthButton.backgroundColor = Color.gigas
        previousMonthButton.layer.cornerRadius = 15
        previousMonthButton.setImage(Asset.calendarArrowLeft.image, for: .normal)

        currentMonthLabel.font = .systemFont(ofSize: 17, weight: .bold)

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

        createButton.layer.cornerRadius = 30
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
//    let width = Int(collectionView.frame.width / 7)
//    let height = Int(collectionView.frame.height) / numberOfWeeksInBaseDate
    return CGSize(width: 45, height: 45)
  }
}
