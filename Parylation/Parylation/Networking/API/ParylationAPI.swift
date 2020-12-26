//
//  ParylationAPI.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import Moya

enum ParylationAPI {
    case signIn(login: String, password: String)
    case signUp(login: String, password: String)
}

// MARK: - TargetType implementation

extension ParylationAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://localhost:8080")!
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "/signIn"
        case .signUp:
            return "/signUp"
        }
    }
    
    var method: Method {
        switch self {
        case .signIn, .signUp:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data() // TODO: Implement custom data via JSON
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
        var headers = ["Content-Type": "application/json"]
        // TODO: Implement custom headers, for example: tokens
        return headers
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
