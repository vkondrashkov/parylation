//
//  HomeMissingItemsView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 13.03.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class HomeMissingItemsView: UIView {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.image = Asset.homeMissingItems.image
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Sizes.value(from: [.iPhone5s: 130], defaultValue: 200))
            $0.height.equalTo(Sizes.value(from: [.iPhone5s: 156], defaultValue: 240))
        }

        titleLabel.text = L10n.homeMissingTitle
        titleLabel.font = .systemFont(
            ofSize: StyleGuide.Header.subtitleFontSize,
            weight: .semibold
        )
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
        }

        descriptionLabel.text = L10n.homeMissingDescription
        descriptionLabel.font = .systemFont(
            ofSize: StyleGuide.Label.fontSize,
            weight: .light
        )
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
