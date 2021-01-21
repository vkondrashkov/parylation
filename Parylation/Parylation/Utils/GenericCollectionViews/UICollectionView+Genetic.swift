//
//  UICollectionView+Genetic.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 18.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReuseIdentifiable {
        self.register(T.self, forCellWithReuseIdentifier: T.reuseId)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReuseIdentifiable {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseId, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseId) at indexPath: \(indexPath)")
        }
        return cell
    }

    func register<T: UICollectionReusableView>(_: T.Type, forSupplementaryViewOfKind elementKind: String) where T: ReuseIdentifiable {
        self.register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseId)
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, for indexPath: IndexPath) -> T where T: ReuseIdentifiable {
        guard let cell = self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseId, for: indexPath) as? T else {
            fatalError("Could not dequeue supplementary view with identifier: \(T.reuseId) at indexPath: \(indexPath)")
        }
        return cell
    }
}
