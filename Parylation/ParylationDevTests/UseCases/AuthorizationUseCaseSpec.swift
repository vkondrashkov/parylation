//
//  AuthorizationUseCaseSpec.swift
//  ParylationDevTests
//
//  Created by Vladislav Kondrashkov on 6/22/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RealmSwift
import RxSwift
import ParylationDomain
import Quick
import Nimble

@testable import ParylationDev

// TODO: Fix in PI-011
final class AuthorizationUseCaseSpec: QuickSpec {
    override func spec() {
        var authorizationUseCase: AuthorizationUseCase!
        
        beforeSuite {
            Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        }
        
        context("when data is correct") {
            beforeEach {
                let realm = try! Realm()
                try! realm.write {
                    let user = User(id: "foo", name: "bar")
                    realm.add(RealmUser.from(user: user))
                }
                
                authorizationUseCase = AuthorizationUseCaseImpl(
                    authorizedUserRepository: AuthorizedUserRepositoryImpl(realm: try! Realm())
                )
            }
            
            describe("on isAuthorized()") {
                it("should return true") {
//                    let authorized = authorizationUseCase.isAuthorized()
//                        .waitAndCollectElements()
//                    expect(authorized.first).to(beTrue())
                }
            }
            
            describe("on fetchUser()") {
                it("should return user") {
//                    let user = authorizationUseCase.fetchCurrentUser()
//                        .waitAndCollectElements()
//                    expect(user.first).to(equal(User(id: "foo", name: "bar")))
                }
            }
        }
        
        context("when data is incorrect") {
            beforeEach {
                let realm = try! Realm()
                try! realm.write {
                    realm.deleteAll()
                }
                
                authorizationUseCase = AuthorizationUseCaseImpl(
                    authorizedUserRepository: AuthorizedUserRepositoryImpl(realm: try! Realm())
                )
            }
            
            describe("on isAuthorized()") {
                it("should return false") {
//                    let authorized = authorizationUseCase.isAuthorized()
//                        .waitAndCollectElements()
//                    expect(authorized.first).to(beFalse())
                }
            }
            
            describe("on fetchUser()") {
                it("should return error") {
//                    let error = authorizationUseCase.fetchCurrentUser()
//                        .waitAndCollectEvents()
//                    expect(error.first?.isFailed).to(beTrue())
                }
            }
        }
    }
}
