//
//  WelcomeInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit

public enum WelcomeInteractorError: Error {
    case failed
}

public protocol WelcomeInteractor { }

public final class WelcomeInteractorImpl {
    public init() { }
}

// MARK: - WelcomeInteractor implementation

extension WelcomeInteractorImpl: WelcomeInteractor { }
