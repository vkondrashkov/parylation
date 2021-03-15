//
//  HomeView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

final class HomeView: UIViewController {
    var viewModel: HomeViewModel!
    
    private let headerBackgroundView = UIView()
    private let headerContentView = UIView()
    private let greetingsTitleLabel = UILabel()
    private let greetingsSubtitleLabel = UILabel()
    private let planButton = UIButton()

    private let missingItemsView = HomeMissingItemsView()
    private let tableView = UITableView()

    private let createButton = UIButton()

    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = UIView()

        view.addSubview(headerBackgroundView)
        headerBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().priority(.high)
        }
        
        let headerMaskView = UIView()
        headerMaskView.backgroundColor = Color.whisper
        view.insertSubview(headerMaskView, belowSubview: headerBackgroundView)
        headerMaskView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(headerBackgroundView.snp.centerY)
        }
        
        headerBackgroundView.addSubview(headerContentView)
        headerContentView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(
                StyleGuide.Header.margins
            )
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
        }
        
        headerContentView.addSubview(greetingsTitleLabel)
        greetingsTitleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        headerContentView.addSubview(greetingsSubtitleLabel)
        greetingsSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(greetingsTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        headerContentView.addSubview(planButton)
        planButton.snp.makeConstraints {
            $0.top.equalTo(greetingsSubtitleLabel.snp.bottom).offset(20)
            $0.height.equalTo(StyleGuide.Button.height)
            $0.bottom.leading.trailing.equalToSuperview()
        }

        view.addSubview(missingItemsView)
        missingItemsView.snp.makeConstraints {
            $0.top.equalTo(headerBackgroundView.snp.bottom).offset(
                Sizes.value(from: [.iPhone5s: 20, .iPhone8: 30], defaultValue: 60)
            )
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Sizes.value(from: [.iPhone5s: 160, .iPhone8: 160], defaultValue: 200))
        }

        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerBackgroundView.snp.bottom).offset(20).priority(.high)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).priority(.high)
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        headerBackgroundView.backgroundColor = Color.whisper
        headerBackgroundView.layer.cornerRadius = 40
        if #available(iOS 13.0, *) {
            headerBackgroundView.layer.cornerCurve = .continuous
        }
        
        greetingsTitleLabel.font = .systemFont(
            ofSize: StyleGuide.Header.titleFontSize,
            weight: .heavy
        )
        greetingsTitleLabel.text = L10n.homeGreetingsTitle("Vladislav")
        greetingsTitleLabel.textColor = Color.gigas
        
        greetingsSubtitleLabel.font = .systemFont(
            ofSize: StyleGuide.Header.subtitleFontSize,
            weight: .ultraLight
        )
        let subtitleText = L10n.homeGreetingsSubtitle
        let date = "Monday"
        let greetingsSubtitleText = NSMutableAttributedString(
            string: subtitleText + date,
            attributes: [
                .font: UIFont.systemFont(
                    ofSize: StyleGuide.Header.subtitleFontSize,
                    weight: .ultraLight
                )
            ]
        )
        greetingsSubtitleText.addAttributes([
            .font: UIFont.systemFont(
                ofSize: StyleGuide.Header.subtitleFontSize,
                weight: .semibold
            )
        ], range: NSRange(location: subtitleText.count, length: date.count))
        greetingsSubtitleLabel.attributedText = greetingsSubtitleText
        greetingsSubtitleLabel.textColor = .black
        
        planButton.setTitle(L10n.homePlanButton.uppercased(), for: .normal)
        planButton.setTitleColor(.black, for: .normal)
        planButton.backgroundColor = Color.marigoldYellow
        planButton.layer.cornerRadius = 20
        if #available(iOS 13.0, *) {
            planButton.layer.cornerCurve = .continuous
        }
        planButton.titleLabel?.font = .systemFont(
            ofSize: StyleGuide.Button.fontSize,
            weight: .semibold
        )
        planButton.layer.applyShadow(
            color: Color.marigoldYellow,
            alpha: 0.5,
            x: 0,
            y: 5,
            blur: 20,
            spread: -20
        )

        missingItemsView.isHidden = true

        tableView.register(HomeTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none

        createButton.layer.cornerRadius = StyleGuide.Button.height / 2
        createButton.backgroundColor = Color.marigoldYellow
        createButton.setImage(Asset.commonTaskPlus.image, for: .normal)
    }

    private func bindViewModel() {
        let dataSource = RxTableViewSectionedReloadDataSource<HomeTableSection>(
            configureCell: { _, tableView, indexPath, item in
                let cell: HomeTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                let viewModel = HomeTableViewCellViewModelImpl(
                    icon: nil,
                    color: Color.gigas,
                    title: item.title
                )
                cell.bindViewModel(viewModel)
                return cell
            },
            titleForHeaderInSection: { dataSource, section in
                return dataSource[section].name
            },
            canEditRowAtIndexPath: { dataSource, indexPath in
                return true
            }
        )

        viewModel.sections
            .debug("🛑 SECTIONS")
            .do(onNext: { [weak self] sections in
                self?.missingItemsView.isHidden = (sections.first?.items ?? []).count != 0
            })
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

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

        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)

        tableView.rx.itemDeleted
            .bind(to: viewModel.deleteTrigger)
            .disposed(by: disposeBag)

        tableView.rx.willDisplayCell
            .map { $0.indexPath }
            .bind(to: viewModel.willDisplayItemTrigger)
            .disposed(by: disposeBag)

        viewModel.itemIcon
            .delay(.milliseconds(1))
            .drive(onNext: { [weak self] icon, indexPath in
                guard let self = self else { return }
                let cell = self.tableView.cellForRow(at: indexPath) as? HomeTableViewCell
                cell?.update(icon: icon.image)
            })
            .disposed(by: disposeBag)

        viewModel.itemColor
            .delay(.milliseconds(1))
            .drive(onNext: { [weak self] color, indexPath in
                guard let self = self else { return }
                let cell = self.tableView.cellForRow(at: indexPath) as? HomeTableViewCell
                cell?.update(color: color.value)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate implementation

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: L10n.homeDeleteButton, handler: { _, indexPath in
            self.viewModel.deleteTrigger.onNext(indexPath)
            tableView.reloadData()
        })

        return [delete]
    }
}
