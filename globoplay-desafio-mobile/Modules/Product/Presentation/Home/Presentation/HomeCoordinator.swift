//
//  HomeCoordinator.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 27/07/23.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    // MARK: - Properties
    
    private let window: UIWindow
    private let rootViewController: UIViewController
    
    // MARK: - Initialization
    
    init(window: UIWindow, rootViewController: UIViewController) {
        self.window = window
        self.rootViewController = rootViewController
    }
    
    // MARK: - Coordinator Methods
    
    func start() {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
