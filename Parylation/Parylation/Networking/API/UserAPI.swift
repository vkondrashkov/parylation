//
//  UserAPI.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 21.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import Moya

enum UserAPI {
    case signIn(login: String, password: String)
    case signUp(login: String, password: String)
    case updateEmail(userId: String, email: String)
    case updateUsername(userId: String, username: String)
    case updatePassword(userId: String, password: String)
    case signOut
}

// MARK: - TargetType implementation

extension UserAPI: TargetType {
    var baseURL: URL {
        let serverURL = Server.current.baseURL
        return URL(string: serverURL.absoluteString + "/user")!
    }

    var path: String {
        switch self {
        case .signIn:
            return "/signIn"
        case .signUp:
            return "/signUp"
        case .updateEmail(let userId, _):
            return "/\(userId)/update/email"
        case .updateUsername(let userId, _):
            return "/\(userId)/update/username"
        case .updatePassword(let userId, _):
            return "/\(userId)/update/password"
        case .signOut:
            return "/signOut"
        }
    }

    var method: Method {
        switch self {
        case .signIn, .signUp, .updateEmail, .updateUsername, .updatePassword, .signOut:
            return .post
        }
    }

    var sampleData: Data {
        let stubName: String
        switch self {
        case .signIn(let login, let password):
            stubName = "signIn-\(login)-\(password)"
        case .signUp(let login, let password):
            stubName = "signUp-\(login)-\(password)"
        case .updateEmail(let userId, let email):
            stubName = "updateEmail-\(userId)-\(email)"
        case .updateUsername(let userId, let username):
            stubName = "updateUsername-\(userId)-\(username)"
        case .updatePassword(let userId, let oldPassword):
            stubName = "updatePassword-\(userId)-\(oldPassword)"
        case .signOut:
            stubName = "signOut"
        }
        return stubbedResponse(stubName)
    }

    var parameters: [String: Any]? {
        switch self {
        case .signIn(let login, let password):
            return [
                "login": login,
                "password": password
            ]
        case .signUp(let login, let password):
            return [
                "login": login,
                "password": password
            ]
        case .updateEmail(_, let email):
            return [
                "email": email
            ]
        case .updateUsername(_, let username):
            return [
                "username": username
            ]
        case .updatePassword(_, let password):
            return [
                "newPassword": password
            ]
        default:
            return nil
        }
    }

    var task: Task {
        if let parameters = self.parameters {
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
        return .requestPlain
    }

    var headers: [String : String]? {
        let headers = ["Content-Type": "application/json"]
        // TODO: Implement custom headers, for example: tokens
        return headers
    }

    var validationType: ValidationType {
        return .successCodes
    }
}

// MARK: - Utils

extension UserAPI {
    private func stubbedResponse(_ name: String) -> Data {
        @objc class TestClass: NSObject { }

        let bundle = Bundle(for: TestClass.self)
        guard let url = bundle.url(forResource: name, withExtension: "json") else {
            return Data()
        }
        return (try? Data(contentsOf: url)) ?? Data()
    }
}
