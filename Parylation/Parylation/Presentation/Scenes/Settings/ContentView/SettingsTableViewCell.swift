//
//  MiddleSettingsTableViewCell.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/25/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class MiddleSettingsTableViewCell: UITableViewCell, ReuseIdentifiable {
    var viewModel: SettingsTableViewCellViewModel?
    
    private let contentBackgroundView = UIView()
    private let iconBackgroundView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let separatorView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentBackgroundView.backgroundColor = Color.whisper
        contentView.addSubview(contentBackgroundView)
        contentBackgroundView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        contentBackgroundView.addSubview(iconBackgroundView)
        iconBackgroundView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.size.equalTo(40)
        }
        
        iconBackgroundView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(25)
            $0.center.equalToSuperview()
        }
        
        contentBackgroundView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconBackgroundView.snp.trailing).offset(15)
            $0.centerY.equalTo(iconBackgroundView)
            $0.trailing.lessThanOrEqualToSuperview().inset(10)
        }
        
        separatorView.backgroundColor = Color.veryLightPink
        contentBackgroundView.addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindViewModel(_ viewModel: SettingsTableViewCellViewModel) {
        self.viewModel = viewModel
        
        viewModel.color
            .bind(to: iconBackgroundView.reactive.backgroundColor)
        viewModel.icon
            .bind(to: iconImageView)
        viewModel.title
            .bind(to: titleLabel)
    }
}
