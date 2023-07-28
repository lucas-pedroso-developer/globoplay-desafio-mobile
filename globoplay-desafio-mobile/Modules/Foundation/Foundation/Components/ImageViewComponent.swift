//
//  LogoImageView.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 28/07/23.
//

import UIKit

class ImageViewComponent: UIImageView {
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        self.contentMode = .scaleAspectFit
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
