//
//  SignInInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 8/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit

public enum SignInInteractorError: Error {
    case failed
}

public protocol SignInInteractor { }

public final class SignInInteractorImpl {
    public init() { }
}

// MARK: - SignInInteractor implementation

extension SignInInteractorImpl: SignInInteractor { }
