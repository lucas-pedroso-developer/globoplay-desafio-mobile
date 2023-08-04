//
//  GenericCollectionView.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 28/07/23.
//

import UIKit

protocol CollectionViewComponentDelegate: AnyObject {
    func didSelectItem(at indexPath: IndexPath)
    func sizeForItemAt(indexPath: IndexPath) -> CGSize
}

class CollectionViewComponent: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    weak var componentDelegate: CollectionViewComponentDelegate?
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDataSource?
    
    // MARK: - Initialization
    
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, dataSource: UICollectionViewDataSource) {
        super.init(frame: frame)
        self.dataSource = dataSource
        setupCollectionView(layout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupCollectionView(layout: UICollectionViewLayout) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        addSubview(collectionView)
        configureCollectionViewConstraints()
    }
    
    private func configureCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    // MARK: - Public Methods
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func registerCell<T: UICollectionViewCell>(_ cellClass: T.Type, forCellWithReuseIdentifier identifier: String) {
        collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    // MARK: - UICollectionViewDataSource Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.collectionView(collectionView, numberOfItemsInSection: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource?.collectionView(collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout Methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return componentDelegate?.sizeForItemAt(indexPath: indexPath) ?? CGSize(width: 50, height: 50)
    }
    
    // MARK: - UICollectionViewDelegate Methods
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        componentDelegate?.didSelectItem(at: indexPath)
    }
    
    // MARK: - Custom Methods
    
    func selectItem(at indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
        componentDelegate?.didSelectItem(at: indexPath)
    }
}
