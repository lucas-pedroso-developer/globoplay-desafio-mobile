//
//  DetailCoordinator.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 10/08/23.
//

import UIKit

class DetailsCoordinator: Coordinator {
    
    // MARK: - Properties
    
    weak var viewController: UIViewController?
    public var movieDetail: MoviesData?
    
    // MARK: - Initialization
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Coordinator Methods

    func start() {
        let detailsViewController = DetailsViewController()
        detailsViewController.movieDetail = movieDetail
        detailsViewController.modalPresentationStyle = .fullScreen
        viewController?.present(detailsViewController, animated: true)
    }
    
    func setMovieData(movie: MoviesData?) {
        self.movieDetail = movie
    }
}
