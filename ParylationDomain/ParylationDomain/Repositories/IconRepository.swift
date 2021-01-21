//
//  IconRepository.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 19.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum IconRepositoryError: Error {
    case failed
    case missingData
}

public protocol IconRepository {
    func fetchAll() -> Single<[Icon]>
    func fetch(id: String) -> Single<Icon>
}
