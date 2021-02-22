//
// 
//  DayView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 10.02.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//
//

import RxCocoa
import RxSwift
import UIKit

final class DayView: UIViewController {
    var viewModel: DayViewModel!

    private let headerTitleLabel = UILabel()
    private let headerSubtitleLabel = UILabel()

    private let previousMonthButton = UIButton()
    private let currentMonthLabel = UILabel()
    private let nextMonthButton = UIButton()

    private let tableView = UITableView()

    private let createButton = UIButton()

    private let disposeBag = DisposeBag()

    override func loadView() {
        view = UIView()

        view.addSubview(headerTitleLabel)
        headerTitleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30).priority(.high)
        }

        view.addSubview(headerSubtitleLabel)
        headerSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(headerTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(30).priority(.high)
        }

        let monthHeaderContainerView = UIView()
        view.addSubview(monthHeaderContainerView)
        monthHeaderContainerView.snp.makeConstraints {
            $0.top.equalTo(headerSubtitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(30).priority(.high)
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

        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(monthHeaderContainerView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20).priority(.high)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
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

        tableView.register(DayTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none

        createButton.layer.cornerRadius = 30
        createButton.backgroundColor = Color.marigoldYellow
        createButton.setImage(Asset.commonTaskPlus.image, for: .normal)
    }

    private func bindViewModel() {
        rx.methodInvoked(#selector(UIViewController.viewWillAppear))
            .map { _ in () }
            .bind(to: viewModel.reloadTrigger)
            .disposed(by: disposeBag)

        createButton.rx.tap
            .bind(to: viewModel.createTrigger)
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .do(onNext: { [weak self] in
                self?.tableView.deselectRow(at: $0, animated: true)
            })
            .bind(to: viewModel.selectTrigger)
            .disposed(by: disposeBag)

        viewModel.items
            .drive(tableView.rx.items(cellIdentifier: DayTableViewCell.reuseId, cellType: DayTableViewCell.self)) { row, item, cell in
                let viewModel = DayTableViewCellViewModelImpl(
                    icon: item.icon,
                    color: item.color,
                    title: item.title
                )
                cell.bindViewModel(viewModel)
            }
            .disposed(by: disposeBag)

        viewModel.selectedDay
            .drive(currentMonthLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
