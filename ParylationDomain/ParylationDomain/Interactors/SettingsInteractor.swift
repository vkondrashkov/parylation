//
//  
//  SettingsInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 8/25/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//
//

import ReactiveKit

public enum SettingsInteractorError: Error {
    case failed
}

public protocol SettingsInteractor { }

public final class SettingsInteractorImpl {
    public init() { }
}

// MARK: - SettingsInteractor implementation

extension SettingsInteractorImpl: SettingsInteractor { }

