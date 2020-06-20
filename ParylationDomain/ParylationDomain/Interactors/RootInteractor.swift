//
//  RootInteractor.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 6/20/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit

public enum RootInteractorError: Error {
    case failed
}

public protocol RootInteractor {
    func isUserAuthorized() -> Signal<Bool, RootInteractorError>
}

public final class RootInteractorImpl {
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
}

// MARK: - RootInteractor implementation

extension RootInteractorImpl: RootInteractor {
    public func isUserAuthorized() -> Signal<Bool, RootInteractorError> {
        userRepository.fetchCurrentUser()
            .map { _ in true }
            .flatMapError { error -> Signal<Bool, RootInteractorError> in
                switch error {
                case .failed:
                    return .failed(.failed)
                case .missingData:
                    return .init(just: false)
                }
        }
    }
}
