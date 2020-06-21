//
//  AuthorizedUserRepository.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RealmSwift
import ReactiveKit
import ParylationDomain

final class AuthorizedUserRepositoryImpl: AuthorizedUserRepository {
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func fetchUser() -> Signal<User, AuthorizedUserRepositoryError> {
        let users = realm.objects(RealmUser.self)
        guard let user = users.first else {
            return .failed(.missingData)
        }
        return Signal(just: user.toDomain())
    }
    
    func saveUser(user: User) -> Signal<Void, AuthorizedUserRepositoryError> {
        return Signal { [weak self] observer in
            guard let self = self else {
                observer.receive(completion: .failure(.failed))
                return SimpleDisposable()
            }
            let realmUser = RealmUser.from(user: user)
            do {
                try self.realm.write {
                    self.realm.add(realmUser)
                }
            } catch {
                observer.receive(completion: .failure(.failed))
            }
            guard self.realm.object(ofType: RealmUser.self, forPrimaryKey: realmUser.id) != nil else {
                observer.receive(completion: .failure(.failed))
                return SimpleDisposable()
            }
            observer.receive()
            observer.receive(completion: .finished)
            return SimpleDisposable()
        }
    }
}
