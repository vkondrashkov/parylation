//
//  CalendarInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 27.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum CalendarInteractorError: Error {
    case failed
}

public protocol CalendarInteractor { }

public final class CalendarInteractorImpl {
    public init() { }
}

// MARK: - CalendarInteractor implementation

extension CalendarInteractorImpl: CalendarInteractor { }

