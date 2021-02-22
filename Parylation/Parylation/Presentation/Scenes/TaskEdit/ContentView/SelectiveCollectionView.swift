//
//  SelectiveCollectionView.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 18.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol SelectiveCollectionViewItem: UICollectionViewCell, ReuseIdentifiable {
    static var size: CGSize { get }
}

class SelectiveCollectionView<Item: SelectiveCollectionViewItem>: UICollectionView {
    private final class SelectiveCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return Item.size
        }
    }

    private var selectiveDelegate: SelectiveCollectionViewDelegate?

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = .clear
        selectiveDelegate = SelectiveCollectionViewDelegate()
        delegate = selectiveDelegate

        register(Item.self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
