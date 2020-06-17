//
//  RootInteractorImpl.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit

final class RootInteractorImpl {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
}

// MARK: - RootInteractor implementation

extension RootInteractorImpl: RootInteractor {
    func isUserAuthorized() -> Signal<Bool, RootInteractorError> {
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
