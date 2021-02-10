//
//  DayInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 10.02.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum DayInteractorError: Error {
    case failed
}

public protocol DayInteractor { }

public final class DayInteractorImpl {
    public init() { }
}

// MARK: - DayInteractor implementation

extension DayInteractorImpl: DayInteractor { }

