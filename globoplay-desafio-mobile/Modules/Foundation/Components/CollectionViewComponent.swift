//
//  GenericCollectionView.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 28/07/23.
//

import UIKit

// MARK: - CollectionViewComponent

class CollectionViewComponent: UICollectionView {

    var imageUrl: URL?
    var itemCount: Int = 0
    
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, cellClass: AnyClass, reuseIdentifier: String) {
        super.init(frame: frame, collectionViewLayout: layout)
        configure(cellClass: cellClass, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configure(cellClass: AnyClass, reuseIdentifier: String) {
        dataSource = self
        delegate = self
        register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

// MARK: - UICollectionViewDataSource

extension CollectionViewComponent: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenericCell", for: indexPath) as! GenericCell
           cell.tintColor = UIColor.red
           cell.backgroundColor = UIColor.white
           if let imageUrl = imageUrl {
           
           }
           return cell
   }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CollectionViewComponent: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = 120
        let cellHeight: CGFloat = 200
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
