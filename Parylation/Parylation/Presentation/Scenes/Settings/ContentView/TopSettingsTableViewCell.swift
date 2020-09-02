//
//  TopSettingsTableViewCell.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/26/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit
import UIKit

final class TopSettingsTableViewCell: UITableViewCell, SettingsTableViewCell, ReuseIdentifiable {
    var viewModel: SettingsTableViewCellViewModel?
    
    private let contentBackgroundView = UIView()
    private let contentMaskView = UIView()
    private let iconBackgroundView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let separatorView = UIView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        viewModel = nil
        iconImageView.image = nil
        titleLabel.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentBackgroundView.backgroundColor = Color.whisper
        contentBackgroundView.layer.cornerRadius = 30
        if #available(iOS 13.0, *) {
            contentBackgroundView.layer.cornerCurve = .continuous
        }
        contentView.addSubview(contentBackgroundView)
        contentBackgroundView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        contentMaskView.backgroundColor = Color.whisper
        contentView.insertSubview(contentMaskView, belowSubview: contentBackgroundView)
        contentMaskView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(contentBackgroundView)
            $0.top.equalTo(contentBackgroundView.snp.centerY)
        }
        
        contentBackgroundView.addSubview(iconBackgroundView)
        iconBackgroundView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().inset(10)
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
