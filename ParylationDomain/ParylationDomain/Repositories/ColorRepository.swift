//
//  ColorRepository.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 19.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum ColorRepositoryError: Error {
    case failed
    case missingData
}

public protocol ColorRepository {
    func fetchAll() -> Single<[Color]>
    func fetch(id: String) -> Single<Color>
}
