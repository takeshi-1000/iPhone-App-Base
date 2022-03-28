//
//  GithubRepository.swift
//  iPhone-App-Base
//
//  Created by 小森　武史 on 2022/03/27.
//

import RxRelay
import RxSwift
import Foundation

protocol GithubRepositoryInputType {
    var fetch: PublishRelay<Void> { get }
}

protocol GithubRepositoryOutputType {
    var repositoryList: PublishRelay<[GithubRepositoryEntity]> { get }
    var error: PublishRelay<Error> { get }
}

protocol GithubRepositoryType {
    var inputs: GithubRepositoryInputType { get }
    var outputs: GithubRepositoryOutputType { get }
}

// StateMachine ↔️ GithubRepository

class GithubRepository: GithubRepositoryType, GithubRepositoryInputType, GithubRepositoryOutputType {
    var inputs: GithubRepositoryInputType { self }
    var outputs: GithubRepositoryOutputType { self }
    
    private let disposeBag = DisposeBag()
    
    // MARK: inputs
    let fetch = PublishRelay<Void>()
    
    // MARK: ouputs
    var repositoryList: PublishRelay<[GithubRepositoryEntity]> { _repositoryList }
    var error: PublishRelay<Error> { _error }
    
    let _repositoryList = PublishRelay<[GithubRepositoryEntity]>()
    let _error = PublishRelay<Error>()
    
    func getRepositories() {
        WebAPIClient
            .call(request: GithubAPI.GetGithubRepositories(parameters: nil)) { response in
                self._repositoryList.accept(response.datas)
            } onError: { error in
                self._error.accept(error)
            }
    }
}
