//
//  HomeViewController.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 27/07/23.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let moviesLabel = LabelComponent()
    private let seriesLabel = LabelComponent()
    private let logoImageView = ImageViewComponent()
    
    private var moviesCollectionView: CollectionViewComponent!
    private var seriesCollectionView: CollectionViewComponent!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupLogoImageView()
        setupMoviesLabel()
        setupMoviesCollectionView()
        setupSeriesLabel()
        setupSeriesCollectionView()
        reloadData()
    }
    
    // MARK: - UI Setup Methods
    
    private func setupLogoImageView() {
        logoImageView.image = UIImage(named: "Logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupMoviesLabel() {
        moviesLabel.text = "Filmes"
        moviesLabel.textColor = .white
        moviesLabel.textAlignment = .center
        moviesLabel.font = UIFont.boldSystemFont(ofSize: 20)
        moviesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(moviesLabel)
        
        NSLayoutConstraint.activate([
            moviesLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            moviesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
    
    private func setupSeriesLabel() {
        seriesLabel.text = "Séries"
        seriesLabel.textColor = .white
        seriesLabel.textAlignment = .center
        seriesLabel.font = UIFont.boldSystemFont(ofSize: 20)
        seriesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(seriesLabel)
        
        NSLayoutConstraint.activate([
            seriesLabel.topAnchor.constraint(equalTo: moviesCollectionView.bottomAnchor, constant: 20),
            seriesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
    
    private func setupMoviesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let frame = CGRect(x: 0, y: 150, width: view.bounds.width, height: 200)
        layout.scrollDirection = .horizontal
        moviesCollectionView = CollectionViewComponent(frame: frame, collectionViewLayout: layout, cellClass: GenericCell.self, reuseIdentifier: "GenericCell")
        moviesCollectionView.itemCount = 4
        moviesCollectionView.register(GenericCell.self, forCellWithReuseIdentifier: "MoviesCell")
        view.addSubview(moviesCollectionView)
    }
    
    private func setupSeriesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let frame = CGRect(x: 0, y: 400, width: view.bounds.width, height: 200)
        layout.scrollDirection = .horizontal
        seriesCollectionView = CollectionViewComponent(frame: frame, collectionViewLayout: layout, cellClass: GenericCell.self, reuseIdentifier: "GenericCell")
        seriesCollectionView.itemCount = 2
        seriesCollectionView.register(GenericCell.self, forCellWithReuseIdentifier: "SeriesCell")
        view.addSubview(seriesCollectionView)
    }
    
    // MARK: - Data Reload
    
    private func reloadData() {
        moviesCollectionView.reloadData()
        seriesCollectionView.reloadData()
    }
}

