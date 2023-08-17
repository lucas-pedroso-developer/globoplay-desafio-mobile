//
//  HomeViewController.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 27/07/23.
//

import Foundation
import UIKit

// MARK: - Protocol

protocol HomeViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(message: String)
    func reloadCollectionView()
}

class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let moviesLabel = LabelComponent()
    private let seriesLabel = LabelComponent()
    private let logoImageView = ImageViewComponent()
    
    var errorComponent: ErrorComponent?
    var moviesCollectionView: CollectionViewComponent?
    var seriesCollectionView: CollectionViewComponent?
    var viewModel: HomeViewModelProtocol?
    var loaderComponent: LoaderComponent?
    
    private var moviesDataSource: MoviesCollectionViewDataSource?
    private var seriesDataSource: SeriesCollectionViewDataSource?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        createViewModel()
        getData()
    }
    
    private func createViewModel() {
        let dependencies = HomeViewModelConfigurator.Dependencies(view: self)
        viewModel = HomeViewModelConfigurator.make(with: dependencies)
    }
    
    private func getData() {
        viewModel?.getData()
    }
    
    // MARK: - UI Setup Methods
    
    private func setupViews() {
        setupLogoImageView()
        setupMoviesLabel()
        setupMoviesCollectionView()
        setupSeriesLabel()
        setupSeriesCollectionView()
    }
            
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
            seriesLabel.topAnchor.constraint(equalTo: moviesCollectionView!.bottomAnchor, constant: 20),
            seriesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
    
    private func setupMoviesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let frame = CGRect(x: 0, y: 150, width: view.bounds.width, height: 200)
        layout.scrollDirection = .horizontal
        let moviesDataSource = MoviesCollectionViewDataSource(moviesEntity: viewModel?.getMoviesData())
        viewModel?.setMoviesDataSource(moviesDataSource: moviesDataSource)
        
        moviesCollectionView = CollectionViewComponent(frame: frame, collectionViewLayout: layout, dataSource: moviesDataSource)
        moviesCollectionView?.componentDelegate = self 
        view.addSubview(moviesCollectionView!)
        moviesCollectionView?.registerCell(GenericCell.self, forCellWithReuseIdentifier: "GenericCell")
    }
    
    private func setupSeriesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let frame = CGRect(x: 0, y: 400, width: view.bounds.width, height: 200)
        layout.scrollDirection = .horizontal
        let seriesDataSource = SeriesCollectionViewDataSource(seriesEntity: viewModel?.getSeriesData())
        viewModel?.setSeriesDataSource(seriesDataSource: seriesDataSource)
        
        seriesCollectionView = CollectionViewComponent(frame: frame, collectionViewLayout: layout, dataSource: seriesDataSource)
        seriesCollectionView?.componentDelegate = self // Set the delegate
        view.addSubview(seriesCollectionView!)
        seriesCollectionView?.registerCell(GenericCell.self, forCellWithReuseIdentifier: "GenericCell")
    }
}

extension HomeViewController: HomeViewProtocol {

    // MARK: - HomeViewProtocol
    
    func showLoading() {
        loaderComponent?.startLoading()
    }

    func hideLoading() {
        loaderComponent?.stopLoading()
    }

    func showError(message: String) {
        errorComponent = ErrorComponent(message: message)
        errorComponent?.delegate = self
        view.addSubview(errorComponent ?? UIView())
        configureErrorComponentConstraints()
    }
    
    private func configureErrorComponentConstraints() {
        errorComponent?.translatesAutoresizingMaskIntoConstraints = false
        errorComponent?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        errorComponent?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        errorComponent?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        errorComponent?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func hideErrorComponent() {
        errorComponent?.removeFromSuperview()
        errorComponent = nil
    }
    
    func reloadCollectionView() {
        setupViews()
        moviesCollectionView?.reloadData()
        seriesCollectionView?.reloadData()
    }
}

extension HomeViewController: ErrorComponentDelegate {
    
    // MARK: - ErrorComponentDelegate
    
    func didTapRefresh() {
        hideErrorComponent()
    }
}

// MARK: - CollectionViewComponentDelegate

extension HomeViewController: CollectionViewComponentDelegate {
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width/3, height: self.view.bounds.width/2.1)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        if let selectedMovie = viewModel?.getSelectedMovie(indexPathItem: indexPath.item) {
            let detailsCoordinator = DetailsCoordinator(viewController: self)
            detailsCoordinator.setMovieData(movie: selectedMovie)
            detailsCoordinator.start()
        } else {
            print("No selected movie found for indexPath: \(indexPath)")
            //TODO: tratar erro
        }
    }
}
