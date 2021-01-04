//
//  CredentialsValidatorUseCase.swift
//  ParylationDomain
//
//  Created by Vladislav Kondrashkov on 27.12.20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import RxSwift

public enum CredentialsValidatorUseCaseError: Error {
    case failed
}

public protocol CredentialsValidatorUseCase: AnyObject {
    func validate(email: String) -> Single<Bool>
    func validate(username: String) -> Single<Bool>
    func validate(password: String) -> Single<Bool>

    func validate(taskTitle: String) -> Single<Bool>
    func validate(taskDescription: String) -> Single<Bool>
}

public final class CredentialsValidatorUseCaseImpl: CredentialsValidatorUseCase {
    private let emailRegexPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    private let usernameRegexPattern = "(?!user\\d*)\\b[a-zA-Z\\d]{3,20}"
    private let passwordRegexPattern = "(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d!@#$&()-`.+,\\\"]{6,24}"

    public init() { }
    
    public func validate(email: String) -> Single<Bool> {
        let result = email.range(of: emailRegexPattern, options: .regularExpression)
        return .just(result != nil)
    }

    public func validate(username: String) -> Single<Bool> {
        let result = username.range(of: usernameRegexPattern, options: .regularExpression)
        return .just(result != nil)
    }

    public func validate(password: String) -> Single<Bool> {
        let result = password.range(of: passwordRegexPattern, options: .regularExpression)
        return .just(result != nil)
    }

    public func validate(taskTitle: String) -> Single<Bool> {
        return .just(!taskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }

    public func validate(taskDescription: String) -> Single<Bool> {
        return .just(!taskDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
}
