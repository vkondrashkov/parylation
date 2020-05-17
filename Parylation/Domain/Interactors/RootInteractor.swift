//
//  RootInteractor.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 5/17/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Bond
import ReactiveKit

enum RootInteractorError: Error {
    case failed
}

protocol RootInteractor {
    func isUserAuthorized() -> Signal<Bool, RootInteractorError>
}
