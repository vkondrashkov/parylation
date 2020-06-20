//
//  SignUpInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 6/20/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit

public enum SignUpInteractorError: Error {
    case failed
}

public protocol SignUpInteractor { }

public final class SignUpInteractorImpl {
    public init() { }
}

// MARK: - SignUpInteractor implementation

extension SignUpInteractorImpl: SignUpInteractor { }
