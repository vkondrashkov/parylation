//
//  CalendarDateCollectionViewCell.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 31.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

final class CalendarDateCollectionViewCell: UICollectionViewCell, ReuseIdentifiable {
    private let selectionBackgroundView = UIView()
    private let numberLabel = UILabel()
    private let accessibilityDateFormatter = DateFormatter()

    var day: Day? {
        didSet {
            guard let day = day else { return }
            updateSelectionStatus()
            numberLabel.text = day.number
            accessibilityLabel = accessibilityDateFormatter.string(from: day.date)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(selectionBackgroundView)
        selectionBackgroundView.layer.cornerRadius = 40 / 2
        selectionBackgroundView.backgroundColor = Color.blazeOrange
        selectionBackgroundView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(40)
        }

        contentView.addSubview(numberLabel)
        numberLabel.textAlignment = .center
        numberLabel.font = .systemFont(ofSize: 17, weight: .bold)
        numberLabel.textColor = .black
        numberLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        accessibilityDateFormatter.calendar = Calendar(identifier: .gregorian)
        accessibilityDateFormatter.setLocalizedDateFormatFromTemplate("EEEE, MMMM d")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Appearance
private extension CalendarDateCollectionViewCell {
    func updateSelectionStatus() {
        guard let day = day else { return }

        if day.isSelected {
            applySelectedStyle()
        } else {
            applyDefaultStyle(isWithinDisplayedMonth: day.isWithinDisplayedMonth)
        }
    }

    func applySelectedStyle() {
        accessibilityTraits.insert(.selected)
        accessibilityHint = nil

        numberLabel.textColor = .white
        selectionBackgroundView.isHidden = false
    }

    func applyDefaultStyle(isWithinDisplayedMonth: Bool) {
        accessibilityTraits.remove(.selected)
        accessibilityHint = "Tap to select"

        numberLabel.textColor = isWithinDisplayedMonth ? .black : .lightGray
        selectionBackgroundView.isHidden = true
    }
}
