//
//  GithubRepoListAction.swift
//  coordinatorPractice
//
//  Created by 小森　武史 on 2022/03/27.
//

enum GithubRepoListAction {
    case fetch
    case succeedToFetch([GithubRepositoryEntity])
    case failToFetch(Error)
}
