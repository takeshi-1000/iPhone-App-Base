//
//  GithubRepoListState.swift
//  coordinatorPractice
//
//  Created by 小森　武史 on 2022/03/27.
//

enum GithubRepoListState {
    case none
    case loading
    case succeed([GithubRepositoryEntity])
    case failed(Error)
}
