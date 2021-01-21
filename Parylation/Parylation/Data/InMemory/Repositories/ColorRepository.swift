//
//  ColorRepository.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 19.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift
import ParylationDomain

final class ColorRepositoryImpl: ColorRepository {
    private let colors: [ParylationDomain.Color] = [
        .init(id: "task-color-gigas", value: Color.gigas),
        .init(id: "task-color-blazeOrange", value: Color.blazeOrange),
        .init(id: "task-color-marigoldYellow", value: Color.marigoldYellow),
    ]

    func fetchAll() -> Single<[ParylationDomain.Color]> {
        return .just(colors)
    }

    func fetch(id: String) -> Single<ParylationDomain.Color> {
        return .create { [weak self] single in
            guard let color = self?.colors.first(where: { $0.id == id }) else {
                single(.error(ColorRepositoryError.missingData))
                return Disposables.create()
            }
            single(.success(color))
            return Disposables.create()
        }
    }
}
