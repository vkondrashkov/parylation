//
//  ProdAppContext.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 9/2/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import ParylationDomain
import RealmSwift
import UIKit

final class AppContextImpl: AppContext {
    let window: UIWindow
    let authorizationUseCase: AuthorizationUseCase
    
    init()  {
        window = UIWindow(frame: UIScreen.main.bounds)
        let authorizedUserRepository = AuthorizedUserRepositoryImpl(realm: try! Realm())
        authorizationUseCase = AuthorizationUseCaseImpl(
            authorizedUserRepository: authorizedUserRepository
        )
    }
}
