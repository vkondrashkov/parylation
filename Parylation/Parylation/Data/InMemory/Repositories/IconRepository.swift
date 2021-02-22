//
//  IconRepository.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 19.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift
import ParylationDomain

final class IconRepositoryImpl: IconRepository {
    private let icons: [Icon] = [
        .init(id: "task-icon-list", image: Asset.taskEditList.image.withRenderingMode(.alwaysTemplate)),
        .init(id: "task-icon-home", image: Asset.taskEditHome.image.withRenderingMode(.alwaysTemplate)),
        .init(id: "task-icon-office", image: Asset.taskEditOffice.image.withRenderingMode(.alwaysTemplate)),
        .init(id: "task-icon-shop", image: Asset.taskEditShop.image.withRenderingMode(.alwaysTemplate)),
        .init(id: "task-icon-heart", image: Asset.taskEditHeart.image.withRenderingMode(.alwaysTemplate)),
        .init(id: "task-icon-star", image: Asset.taskEditStar.image.withRenderingMode(.alwaysTemplate)),
        .init(id: "task-icon-key", image: Asset.taskEditKey.image.withRenderingMode(.alwaysTemplate)),
        .init(id: "task-icon-mail", image: Asset.taskEditMail.image.withRenderingMode(.alwaysTemplate)),
        .init(id: "task-icon-bookmark", image: Asset.taskEditBookmark.image.withRenderingMode(.alwaysTemplate)),
        .init(id: "task-icon-dictionary", image: Asset.taskEditDictionary.image.withRenderingMode(.alwaysTemplate))
    ]

    func fetchAll() -> Single<[Icon]> {
        return .just(icons)
    }

    func fetch(id: String) -> Single<Icon> {
        return .create { [weak self] single in
            guard let icon = self?.icons.first(where: { $0.id == id }) else {
                single(.error(IconRepositoryError.missingData))
                return Disposables.create()
            }
            single(.success(icon))
            return Disposables.create()
        }
    }
}

