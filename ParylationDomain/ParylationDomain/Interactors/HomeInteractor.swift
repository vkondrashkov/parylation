//
//  HomeInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 8/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit

public enum HomeInteractorError: Error {
    case failed
}

public protocol HomeInteractor { }

public final class HomeInteractorImpl {
    public init() { }
}

// MARK: - HomeInteractor implementation

extension HomeInteractorImpl: HomeInteractor { }
