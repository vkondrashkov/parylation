//
//  SettingsTableViewCell.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 9/10/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class SettingsTableViewCell: UITableViewCell, ReuseIdentifiable {
    enum CellType {
        case top
        case middle
        case bottom
        case single
    }

    var viewModel: SettingsTableViewCellViewModel?

    var cellType: CellType = .single {
        didSet {
            updateLayoutAccording(cellType: cellType)
        }
    }

    private let contentBackgroundView = UIView()
    private let contentMaskView = UIView()
    private let iconBackgroundView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let separatorView = UIView()

    private var disposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()

        disposeBag = DisposeBag()
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
        contentBackgroundView.addSubview(iconBackgroundView)

        updateLayoutAccording(cellType: cellType)

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
            .drive(iconBackgroundView.rx.backgroundColor)
            .disposed(by: disposeBag)
        viewModel.icon
            .drive(iconImageView.rx.image)
            .disposed(by: disposeBag)
        viewModel.title
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
    }

    private func updateLayoutAccording(cellType: CellType) {
        switch cellType {
        case .top:
            contentMaskView.snp.remakeConstraints {
                $0.bottom.leading.trailing.equalTo(contentBackgroundView)
                $0.top.equalTo(contentBackgroundView.snp.centerY)
            }

            iconBackgroundView.snp.remakeConstraints {
                $0.top.leading.equalToSuperview().offset(20)
                $0.bottom.equalToSuperview().inset(10)
                $0.size.equalTo(40)
            }
        case .middle:
            contentMaskView.snp.remakeConstraints {
                $0.edges.equalTo(contentBackgroundView)
            }

            iconBackgroundView.snp.remakeConstraints {
                $0.leading.equalToSuperview().offset(20)
                $0.top.bottom.equalToSuperview().inset(10)
                $0.size.equalTo(40)
            }
        case .bottom:
            contentMaskView.snp.remakeConstraints {
                $0.top.leading.trailing.equalTo(contentBackgroundView)
                $0.bottom.equalTo(contentBackgroundView.snp.centerY)
            }

            iconBackgroundView.snp.remakeConstraints {
                $0.bottom.leading.equalToSuperview().inset(20)
                $0.top.equalToSuperview().inset(10)
                $0.size.equalTo(40)
            }
        case .single:
            contentMaskView.snp.remakeConstraints {
                $0.leading.trailing.equalTo(contentBackgroundView)
                $0.top.bottom.equalTo(contentBackgroundView.snp.centerY)
            }

            iconBackgroundView.snp.remakeConstraints {
                $0.top.bottom.leading.equalToSuperview().inset(20)
                $0.size.equalTo(40)
            }
        }
    }
}

