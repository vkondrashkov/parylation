//
//  Server.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 21.01.21.
//  Copyright © 2021 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

enum Server {
    case local
    case stage
    case production

    var baseURL: URL {
        switch self {
        case .local:
            return URL(string: "https://localhost:8080")!
        case .stage:
            return URL(string: "")!
        case .production:
            return URL(string: "")!
        }
    }

    static var current: Server = .local
}
