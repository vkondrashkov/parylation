//
//  SettingsTableView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 8/25/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol SettingsTableViewCell: UITableViewCell {
    func bindViewModel(_ viewModel: SettingsTableViewCellViewModel)
}

final class SettingsTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 60
        backgroundColor = .clear
        register(TopSettingsTableViewCell.self)
        register(MiddleSettingsTableViewCell.self)
        register(BottomSettingsTableViewCell.self)
        register(SingleSettingsTableViewCell.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
