//
//  AppCoordinator.swift
//  iPhone-App-Base
//
//  Created by 小森　武史 on 2022/03/27.
//

import UIKit

protocol RootCoordinatorDegate: AnyObject {
    func coordinateToMainTabBar()
}

class RootCoordinator: Coordinator {
    private let window: UIWindow
    private var rootVC: RootViewController!
    private var mainTabBarCoordinator: MainTabBarCoorinator!
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        rootVC = RootViewController()
        let stateMachine = AppStateMachine.shared
        rootVC.viewModel = RootViewModel(stateMachine: stateMachine)
        rootVC.delegate = self
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
    }
}

extension RootCoordinator: RootCoordinatorDegate {
    func coordinateToMainTabBar() {
        mainTabBarCoordinator = MainTabBarCoorinator(parent: rootVC)
        mainTabBarCoordinator.start()
    }
}
