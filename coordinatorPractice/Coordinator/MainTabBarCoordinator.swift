//
//  FirstCoordinator.swift
//  coordinatorPractice
//
//  Created by 小森　武史 on 2022/03/27.
//

import UIKit

protocol MainTabBarCoordinatorDelegate {}

class MainTabBarCoorinator {
    private let parent: UIViewController
    private var mainTabBarVC: MainTabBarController!
    
    init(parent: UIViewController) {
        self.parent = parent
    }
    
    func start() {
        mainTabBarVC = MainTabBarController()
        
        let githubRepoListVC = GithubRepoListViewController()
        let githubRepository = GithubRepository()
        let stateMachine = GithubRepoListStateMachine(githubRepository: githubRepository)
        githubRepoListVC.viewModel = GithubRepoListViewModel(stateMachine: stateMachine)
        
        let secondVC = SecondViewController()
        mainTabBarVC.setViewControllers([githubRepoListVC, secondVC], animated: false)
        
        mainTabBarVC.modalPresentationStyle = .overFullScreen
        
        parent.present(mainTabBarVC, animated: true, completion: nil)
    }
    
}

extension MainTabBarCoorinator: MainTabBarCoordinatorDelegate {
    
}
