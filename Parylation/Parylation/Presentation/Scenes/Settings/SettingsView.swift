//
// 
//  SettingsView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/25/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

final class SettingsView: UIViewController {
    var viewModel: SettingsViewModel!
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let settingsTableView = SettingsTableView()
    
    private let headerTitleLabel = UILabel()
    private let headerSubtitleLabel = UILabel()

    private let disposeBag = DisposeBag()

    override func loadView() {
        view = UIView()
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        contentView.backgroundColor = .white
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(view.safeAreaLayoutGuide.snp.height).priority(.low)
        }

        contentView.addSubview(headerTitleLabel)
        headerTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.lessThanOrEqualToSuperview().offset(-30)
        }

        contentView.addSubview(headerSubtitleLabel)
        headerSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(headerTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.lessThanOrEqualToSuperview().offset(-30)
        }

        contentView.addSubview(settingsTableView)
        settingsTableView.snp.makeConstraints {
            $0.top.equalTo(headerSubtitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
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
        headerTitleLabel.text = L10n.settingsTitle
        headerTitleLabel.textColor = Color.gigas
        
        headerSubtitleLabel.font = .systemFont(ofSize: 24, weight: .ultraLight)
        let subtitleText = L10n.settingsSubtitle
        let accent = L10n.settingsSubtitleAccent
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
        
        settingsTableView.tableFooterView = nil
        settingsTableView.separatorStyle = .none
    }

    private func bindViewModel() {
        let dataSource = RxTableViewSectionedReloadDataSource<SettingsTableSection>(
            configureCell: { dataSource, tableView, indexPath, item in
                let cell: SettingsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                let itemsCount = dataSource[indexPath.section].items.count
                if itemsCount == 1 {
                    cell.cellType = .single
                } else if indexPath.row == 0 {
                    cell.cellType = .top
                } else if indexPath.row == itemsCount - 1 {
                    cell.cellType = .bottom
                } else {
                    cell.cellType = .middle
                }
                let viewModel = SettingsTableViewCellViewModelImpl(
                    icon: item.icon,
                    color: item.color,
                    title: item.title
                )
                cell.bindViewModel(viewModel)
                return cell
            },
            titleForHeaderInSection: { dataSource, section in
                return dataSource[section].name
            }
        )

        viewModel.sections
            .asObservable()
            .bind(to: settingsTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        settingsTableView.rx.itemSelected
            .do(onNext: { [weak self] in
                self?.settingsTableView.deselectRow(at: $0, animated: true)
            })
            .bind(to: viewModel.selectTrigger)
            .disposed(by: disposeBag)

        settingsTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate implementation

extension SettingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let header = UILabel()
        header.font = .systemFont(ofSize: 17, weight: .semibold)

        view.addSubview(header)
        header.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().offset(-10)
        }

        viewModel.sections
            .drive(onNext: {
                header.text = $0[section].name
            })
            .disposed(by: disposeBag)
        return view
    }
}
