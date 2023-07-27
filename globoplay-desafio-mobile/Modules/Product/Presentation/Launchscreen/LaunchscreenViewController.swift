//
//  LaunchscreenViewController.swift
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
    }
}
