//
//  GithubRepositoryEntity.swift
//  coordinatorPractice
//
//  Created by 小森　武史 on 2022/03/27.
//

struct GetGithubRepositoriesResponse: Codable {
    var datas: [GithubRepositoryEntity]
}

struct GithubRepositoryEntity: Codable {
    var id: Int
    var name: String
}
