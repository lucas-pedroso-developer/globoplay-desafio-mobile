//
//  LaunchscreenCoordinator.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 27/07/23.
//

import UIKit

class LaunchCoordinator: Coordinator {
    private let window: UIWindow
    private var launchScreenViewController: LaunchScreenViewController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Coordinator
    
    func start() {
        let launchScreenViewController = LaunchScreenViewController()
        self.launchScreenViewController = launchScreenViewController
        window.rootViewController = launchScreenViewController
        window.makeKeyAndVisible()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showHomeTabBarController()
        }
    }
    
    // MARK: - Private Methods

    private func showHomeTabBarController() {
        let homeViewController = HomeViewController()
        homeViewController.title = "Início"

        let myListViewController = MyListViewController()
        myListViewController.title = "Minha Lista"

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeViewController, myListViewController]

        tabBarController.tabBar.barTintColor = .black
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.7)

        if let items = tabBarController.tabBar.items {
            for (index, item) in items.enumerated() {
                switch index {
                case 0:
                    item.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate) // Alterado para .alwaysTemplate
                case 1:
                    item.image = UIImage(named: "star")?.withRenderingMode(.alwaysTemplate) // Alterado para .alwaysTemplate
                default:
                    break
                }
                
                item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
                item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
            }
        }

        window.rootViewController = tabBarController
        launchScreenViewController = nil
    }


}


