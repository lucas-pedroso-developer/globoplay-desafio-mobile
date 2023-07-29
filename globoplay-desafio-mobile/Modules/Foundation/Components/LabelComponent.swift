//
//  TitleLabel.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 28/07/23.
//

import UIKit

class LabelComponent: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        textColor = .white
        font = UIFont.boldSystemFont(ofSize: 20)
        textAlignment = .center
    }
}
