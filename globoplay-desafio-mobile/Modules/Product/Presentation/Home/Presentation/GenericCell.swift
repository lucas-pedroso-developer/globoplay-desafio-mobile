//
//  GenericCell.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 28/07/23.
//

import UIKit

public class GenericCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    let genericImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "noImage") 
        return imageView
    }()

    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    // MARK: - UI Setup Method

    private func setupViews() {
        addSubview(genericImageView)
        
        genericImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        genericImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        genericImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        genericImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
