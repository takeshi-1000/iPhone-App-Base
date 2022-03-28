//
//  Request.swift
//  iPhone-App-Base
//
//  Created by 小森　武史 on 2022/03/28.
//

import Foundation

protocol BaseRequestProtocol {
    associatedtype ResponseType: Codable
    
    var baseURL: String { get }
    var path: String { get }
    var parameters: [WebAPIParameter]? { get }
    func request() -> URLRequest?
}

extension BaseRequestProtocol {
    var baseURL: String {
        "https://github.api.com/"
    }
    
    func request() -> URLRequest? {
        guard let url = URL(string: path) else {
            return nil
        }
        return URLRequest(url: url)
    }
}

enum GithubAPI {
    
    struct GetGithubRepositories: BaseRequestProtocol {
        typealias ResponseType = GetGithubRepositoriesResponse
        var path: String { "\(baseURL)/repositories" }
        var parameters: [WebAPIParameter]?
        
        init(parameters: [WebAPIParameter]?) {
            self.parameters = parameters
        }
    }
    
}
