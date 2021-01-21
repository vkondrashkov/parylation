//
//  SelectiveIconCollectionViewCell.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 18.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class SelectiveIconCollectionViewCell: UICollectionViewCell {
    private let backgroundContentView = UIView()
    var selectionColor: UIColor? {
        didSet {
            selectionView.layer.borderColor = selectionColor?.cgColor
        }
    }
    let iconImageView = UIImageView()
    private let selectionView = UIView()

    override var isSelected: Bool {
        didSet {
            selectionView.isHidden = !isSelected
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        iconImageView.image = nil
        selectionView.isHidden = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        backgroundContentView.layer.cornerRadius = 15
        backgroundContentView.backgroundColor = .white
        contentView.addSubview(backgroundContentView)
        backgroundContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        iconImageView.tintColor = .black
        iconImageView.contentMode = .scaleAspectFit
        backgroundContentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(30)
        }

        selectionView.isHidden = true
        selectionView.layer.cornerRadius = 15
        selectionView.layer.borderColor = Color.gigas.cgColor
        selectionView.layer.borderWidth = 2
        backgroundContentView.addSubview(selectionView)
        selectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SelectiveCollectionViewItem implementation

extension SelectiveIconCollectionViewCell: SelectiveCollectionViewItem {
    static var size: CGSize {
        return CGSize(width: 60, height: 60)
    }
}
