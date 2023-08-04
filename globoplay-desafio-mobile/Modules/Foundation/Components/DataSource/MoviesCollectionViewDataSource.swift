//
//  MoviesCollectionViewDataSource.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 04/08/23.
//

import UIKit
import Foundation

class MoviesCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    var movies: MoviesEntity?

    init(moviesEntity: MoviesEntity?) {
        self.movies = moviesEntity
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.results.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenericCell", for: indexPath) as? GenericCell else { return UICollectionViewCell() }
        cell.backgroundColor = .clear
        let url = "https://image.tmdb.org/t/p/w500" + (movies?.results[indexPath.item].posterPath ?? String())
        
        if let imageUrl = URL(string: url) {
            DispatchQueue.main.async {
                cell.genericImageView.loadImage(from: imageUrl)
            }
            
        }
        return cell
    }
    
    func updateMovies(movies: MoviesEntity) {
        self.movies = movies
    }
}
