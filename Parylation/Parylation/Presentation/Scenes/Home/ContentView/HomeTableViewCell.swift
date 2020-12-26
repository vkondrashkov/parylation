//
//  HomeTableViewCell.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 20.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class HomeTableViewCell: UITableViewCell, ReuseIdentifiable {
    var viewModel: HomeTableViewCellViewModel?

    private let contentBackgroundView = UIView()
    private let iconBackgroundView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()

    private var disposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()

        disposeBag = DisposeBag()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentBackgroundView.backgroundColor = Color.whisper
        contentBackgroundView.layer.cornerRadius = 15
        if #available(iOS 13.0, *) {
            contentBackgroundView.layer.cornerCurve = .continuous
        }
        contentView.addSubview(contentBackgroundView)
        contentBackgroundView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(5)
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        iconBackgroundView.layer.cornerRadius = 10
        if #available(iOS 13.0, *) {
            iconBackgroundView.layer.cornerCurve = .continuous
        }
        contentBackgroundView.addSubview(iconBackgroundView)
        iconBackgroundView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(10)
            $0.size.equalTo(40)
        }

        iconBackgroundView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(20)
            $0.center.equalToSuperview()
        }

        titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        contentBackgroundView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconBackgroundView.snp.trailing).offset(15)
            $0.centerY.equalTo(iconBackgroundView)
            $0.trailing.lessThanOrEqualToSuperview().inset(10)
        }
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let color = highlighted ? .lightGray : Color.whisper
        guard animated else {
            contentBackgroundView.backgroundColor = color
            return
        }
        UIView.animate(
            withDuration: 0.25,
            animations: {
                self.contentBackgroundView.backgroundColor = color
            }
        )
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        let color = selected ? .lightGray : Color.whisper
        guard animated else {
            contentBackgroundView.backgroundColor = color
            return
        }
        UIView.animate(
            withDuration: 0.25,
            animations: {
                self.contentBackgroundView.backgroundColor = color
            }
        )
    }

    func bindViewModel(_ viewModel: HomeTableViewCellViewModel) {
        self.viewModel = viewModel

        viewModel.icon
            .drive(iconImageView.rx.image)
            .disposed(by: disposeBag)

        viewModel.color
            .drive(iconBackgroundView.rx.backgroundColor)
            .disposed(by: disposeBag)

        viewModel.title
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
