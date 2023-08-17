//
//  DetailViewController.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 10/08/23.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var movieDetail: MoviesData?
    
    // MARK: - UI Components
    
    private let backgroundImage = ImageViewComponent()
    private let backButton = UIButton(type: .system)
    private let movieImage = ImageViewComponent()
    private let movieNameLabel = LabelComponent()
    private let movieCategoryLabel = LabelComponent()
    private let movieDescriptionTextView = UITextView()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        fillFields()
    }
    
    private func setupUI() {
        setupLogoImageView()
        setupBackButton()
        setupMovieImage()
        setupMovieNameLabel()
        setupMovieCategoryLabel()
        setupMovieDescriptionTextView()
    }
    
    private func setupLogoImageView() {
        backgroundImage.image = UIImage(named: "Logo")
        backgroundImage.contentMode = .scaleAspectFit
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImage)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setupBackButton() {
        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = .white
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 30)
        ])

        //backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func setupMovieImage() {
        movieImage.contentMode = .scaleAspectFit
        movieImage.image = UIImage(named: "noImage")
        view.addSubview(movieImage)
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 0),
            movieImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: 200),
            movieImage.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setupMovieNameLabel() {
        movieNameLabel.text = "Title Label"
        movieNameLabel.textColor = .white
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movieNameLabel)
        
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 20),
            movieNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            movieNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

    }
    
    private func setupMovieCategoryLabel() {
        movieCategoryLabel.text = "Category Label"
        movieCategoryLabel.textColor = .white
        movieCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movieCategoryLabel)
        
        NSLayoutConstraint.activate([
            movieCategoryLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 20),
            movieCategoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            movieCategoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

    }
    
    private func setupMovieDescriptionTextView() {
        movieDescriptionTextView.textColor = .white
        movieDescriptionTextView.backgroundColor = .black
        movieDescriptionTextView.font = UIFont.systemFont(ofSize: 16)
        movieDescriptionTextView.text = "Your text here..."
        movieDescriptionTextView.isEditable = false
        movieDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(movieDescriptionTextView)
        
        NSLayoutConstraint.activate([
            movieDescriptionTextView.topAnchor.constraint(equalTo: movieCategoryLabel.bottomAnchor, constant: 20),
            movieDescriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            movieDescriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            movieDescriptionTextView.heightAnchor.constraint(equalToConstant: 150)
        ])

    }
    
}

//    // MARK: - Actions
//
//    @objc private func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
//}

extension DetailsViewController {
    func fillFields() {
        if let movieName = self.movieDetail?.title {
            self.movieNameLabel.text = movieName
        }
        if let movieDescription = self.movieDetail?.overview {
            self.movieDescriptionTextView.text = movieDescription
        }
                        
        movieCategoryLabel.text = "Filme"
        
        if let backdrop_path = self.movieDetail?.backdropPath {
            if let url = URL(string: "https://image.tmdb.org/t/p/w500" + backdrop_path) {
                self.movieImage.loadImage(from: url)
            }
        }
        
        if let poster_path = self.movieDetail?.posterPath {
            if let url = URL(string: "https://image.tmdb.org/t/p/w500" + poster_path) {
                self.backgroundImage.loadImage(from: url)
            }
        }
    }
}
