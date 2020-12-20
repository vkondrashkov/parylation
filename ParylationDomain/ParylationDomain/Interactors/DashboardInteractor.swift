//
//  DashboardInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 6/20/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum DashboardInteractorError: Error {
    case failed
}

public protocol DashboardInteractor { }

public final class DashboardInteractorImpl {
    public init() { }
}

// MARK: - DashboardInteractor implementation

extension DashboardInteractorImpl: DashboardInteractor { }
