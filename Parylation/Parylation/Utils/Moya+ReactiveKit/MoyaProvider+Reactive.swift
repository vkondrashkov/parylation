//
//  MoyaProvider+Reactive.swift
//  Parylation
//
//  Created by Vladislav Kondrashkov on 6/21/20.
//  Copyright © 2020 Vladislav Kondrashkov. All rights reserved.
//

import ReactiveKit
import Moya
import ObjectMapper

extension MoyaProvider: ReactiveExtensionsProvider { }

extension Reactive where Base: MoyaProviderType {
    func request(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Signal<Response, MoyaError> {
        return Signal { observer in
            let cancellableToken = self.base.request(token, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    observer.receive(response)
                    observer.receive(completion: .finished)
                case let .failure(error):
                    observer.receive(completion: .failure(error))
                }
            }
            return BlockDisposable {
                cancellableToken.cancel()
            }
        }
    }
    
    func request<T: BaseMappable>(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Signal<T, MoyaError> {
        return request(token, callbackQueue: callbackQueue)
            .flatMapConcat { data -> Signal<T, MoyaError> in
                guard let json = try? data.mapJSON() as? [String: Any] else {
                    return .failed(.jsonMapping(data))
                }
                guard let mappableObject = Mapper<T>().map(JSON: json) else {
                    return .failed(.objectMapping(NSError(), data))
                }
                return Signal<T, MoyaError>(just: mappableObject)
            }
    }
    
    func requestForArray<T: BaseMappable>(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Signal<[T], MoyaError> {
        return request(token, callbackQueue: callbackQueue)
            .flatMapConcat { data -> Signal<[T], MoyaError> in
                guard let json = try? data.mapJSON() as? [[String: Any]] else {
                    return .failed(.jsonMapping(data))
                }
                let mappableObjects = Mapper<T>().mapArray(JSONArray: json)
                return Signal<[T], MoyaError>(just: mappableObjects)
            }
    }
}
