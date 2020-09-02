//
// 
//  SettingsView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/25/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import Bond
import ReactiveKit
import UIKit

final class SettingsView: UIViewController {
    var viewModel: SettingsViewModel!
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let settingsTableView = SettingsTableView()
    
    private let headerTitleLabel = UILabel()
    private let headerSubtitleLabel = UILabel()

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
            $0.height.equalToSuperview().priority(.low)
        }
        
        contentView.addSubview(settingsTableView)
        settingsTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
//        view.addSubview(headerTitleLabel)
//        headerTitleLabel.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
//            $0.leading.equalToSuperview().offset(30)
//            $0.trailing.lessThanOrEqualToSuperview().offset(-30)
//        }
//
//        view.addSubview(headerSubtitleLabel)
//        headerSubtitleLabel.snp.makeConstraints {
//            $0.top.equalTo(headerTitleLabel.snp.bottom).offset(10)
//            $0.leading.equalToSuperview().offset(30)
//            $0.trailing.lessThanOrEqualToSuperview().offset(-30)
//        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        headerTitleLabel.font = .systemFont(ofSize: 28, weight: .heavy)
        headerTitleLabel.text = "Edit your workspace" // localize
        headerTitleLabel.textColor = Color.gigas
        
        headerSubtitleLabel.font = .systemFont(ofSize: 24, weight: .ultraLight)
        let subtitleText = "Update your " // localize
        let accent = "settings"
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
        viewModel.sections
            .bind(to: settingsTableView, createCell: { items, indexPath, tableView in
                var cell: SettingsTableViewCell
                let section = items[indexPath.section]
                let itemsCount = section.items.count
                guard itemsCount >= 1 else { return UITableViewCell() }
                if itemsCount == 1 {
                    let singleCell: SingleSettingsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                    cell = singleCell
                } else if indexPath.row == 0 {
                    let topCell: TopSettingsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                    cell = topCell
                } else if indexPath.row == itemsCount - 1 {
                    let bottomCell: BottomSettingsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                    cell = bottomCell
                } else {
                    let middleCell: MiddleSettingsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                    cell = middleCell
                }
                let item = section.items[indexPath.row]
                let viewModel = SettingsTableViewCellViewModelImpl(
                    icon: item.icon,
                    color: item.color,
                    title: item.title
                )
                cell.bindViewModel(viewModel)
                return cell
            })
    }
}
