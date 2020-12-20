//
//  AuthorizedUserRepository.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RealmSwift
import RxSwift
import ParylationDomain

final class AuthorizedUserRepositoryImpl: AuthorizedUserRepository {
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func fetchUser() -> Single<User> {
        let users = realm.objects(RealmUser.self)
        guard let user = users.first else {
            return .error(AuthorizedUserRepositoryError.missingData)
        }
        return .just(user.toDomain())
    }
    
    func saveUser(user: User) -> Single<Void> {
        return .create { [weak self] single in
            guard let self = self else {
                single(.error(AuthorizedUserRepositoryError.failed))
                return Disposables.create()
            }
            let realmUser = RealmUser.from(user: user)
            do {
                try self.realm.write {
                    self.realm.add(realmUser)
                }
            } catch {
                single(.error(AuthorizationUseCaseError.failed))
            }
            guard self.realm.object(ofType: RealmUser.self, forPrimaryKey: realmUser.id) != nil else {
                single(.error(AuthorizationUseCaseError.failed))
                return Disposables.create()
            }
            single(.success(()))
            return Disposables.create()
        }
    }
}
