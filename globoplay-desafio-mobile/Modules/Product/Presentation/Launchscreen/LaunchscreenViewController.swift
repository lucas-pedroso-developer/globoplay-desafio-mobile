//
//  LaunchscreenViewController.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 27/07/23.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // MARK: - UI Setup
        
        let imageView = UIImageView(image: UIImage(named: "Logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        // MARK: - Constraints
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
