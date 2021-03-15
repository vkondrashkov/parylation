//
//  SelectiveColorCollectionViewCell.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 18.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class SelectiveColorCollectionViewCell: UICollectionViewCell {
    private let backgroundContentView = UIView()
    var color: UIColor? {
        didSet {
            secondSelectionView.layer.borderColor = color?.cgColor
            backgroundContentView.backgroundColor = color
        }
    }
    private let selectionView = UIView()
    private let secondSelectionView = UIView()

    override var isSelected: Bool {
        didSet {
            selectionView.isHidden = !isSelected
            secondSelectionView.isHidden = !isSelected
        }
    }

    static let itemSize: CGFloat = Sizes.value(from: [.iPhone5s: 50], defaultValue: 60)

    override func prepareForReuse() {
        super.prepareForReuse()

        selectionView.isHidden = true
        secondSelectionView.isHidden = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        backgroundContentView.layer.cornerRadius = SelectiveColorCollectionViewCell.itemSize / 2
        backgroundContentView.backgroundColor = .white
        contentView.addSubview(backgroundContentView)
        backgroundContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        selectionView.isHidden = true
        selectionView.layer.cornerRadius = SelectiveColorCollectionViewCell.itemSize / 2
        selectionView.layer.borderColor = UIColor.white.cgColor
        selectionView.layer.borderWidth = 7
        backgroundContentView.addSubview(selectionView)
        selectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        secondSelectionView.isHidden = true
        secondSelectionView.layer.cornerRadius = SelectiveColorCollectionViewCell.itemSize / 2
        secondSelectionView.layer.borderColor = color?.cgColor
        secondSelectionView.layer.borderWidth = 2
        backgroundContentView.addSubview(secondSelectionView)
        secondSelectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SelectiveCollectionViewItem implementation

extension SelectiveColorCollectionViewCell: SelectiveCollectionViewItem {
    static var size: CGSize {
        return CGSize(width: itemSize, height: itemSize)
    }
}
