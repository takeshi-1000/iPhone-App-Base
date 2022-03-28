//
//  WebAPIClient.swift
//  coordinatorPractice
//
//  Created by 小森　武史 on 2022/03/27.
//

import RxSwift
import Foundation

class WebAPIClient {
        
    static func call<T, V>(request: T, onSuccess: @escaping (V) -> Void, onError: @escaping (Error) -> Void) where T: BaseRequestProtocol, T.ResponseType == V {
        guard let request = request.request() else { return }
        
        URLSession
            .shared
            .dataTask(with: request) { data, _, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        onSuccess(try decoder.decode(V.self, from: data))
                    } catch let error {
                        onError(error)
                    }
                }
                if let error = error {
                    onError(error)
                }
            }
    }
}
