//
//  HomeViewModel.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 29/07/23.
//

import Foundation
import Combine

protocol HomeViewModelProtocol {
    func getData()
    func getMoviesData() -> MoviesEntity
    func getSeriesData() -> SeriesEntity
    func getMoviesNumberOfRows(index: Int) -> Int
    func getSeriesNumberOfRows(index: Int) -> Int
    func setMoviesData(moviesEntity: MoviesEntity)
    func setSeriesData(seriesEntity: SeriesEntity)
    func setMoviesDataSource(moviesDataSource: MoviesCollectionViewDataSource)
    func setSeriesDataSource(seriesDataSource: SeriesCollectionViewDataSource)
}

class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Properties
    
    var moviesEntity: MoviesEntity?
    var seriesEntity: SeriesEntity?
    weak var view: HomeViewProtocol?
    private let homeUseCase: HomeUseCaseProtocol
    var cancellables = Set<AnyCancellable>()
    
    var moviesDataSource: MoviesCollectionViewDataSource?
    var seriesDataSource: SeriesCollectionViewDataSource?
    
    // MARK: - Initialization
    
    init(view: HomeViewProtocol, homeUseCase: HomeUseCaseProtocol) {
        self.view = view
        self.homeUseCase = homeUseCase
    }
}

extension HomeViewModel {
    
    // MARK: - Methods
    
    func getData() {
        
        view?.showLoading()
        
        let moviesPublisher = Future<MoviesEntity, Error> { promise in
            self.homeUseCase.getMovies { result in
                switch result {
                case .success(let moviesData):
                    promise(.success(moviesData))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        
        let seriesPublisher = Future<SeriesEntity, Error> { promise in
            self.homeUseCase.getSeries { result in
                switch result {
                case .success(let seriesData):
                    promise(.success(seriesData))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        
        Publishers.Zip(moviesPublisher, seriesPublisher)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    let errorMessage: String
                    if let customError = error as? HttpError {
                        errorMessage = customError.localizedDescription
                    } else {
                        errorMessage = "Failed to fetch data"
                    }
                    self.view?.showError(message: errorMessage)
                    self.view?.hideLoading()
                }
            }, receiveValue: { [weak self] movies, series in
                guard let self = self else { return }
                
                self.moviesEntity = movies
                self.seriesEntity = series
                                
                self.moviesDataSource?.updateMovies(movies: movies)
                self.seriesDataSource?.updateSeries(series: series)
                
                self.view?.reloadCollectionView()
            })
            .store(in: &cancellables)
    }
    
    
}

extension HomeViewModel {
    
    // MARK: - Methods
    
    func getMoviesNumberOfRows(index: Int) -> Int {
        return moviesEntity?.results.count ?? Int()
    }
    
    func getSeriesNumberOfRows(index: Int) -> Int {
        return seriesEntity?.results.count ?? Int()
    }
    
    func getMoviesData() -> MoviesEntity {
        return moviesEntity ?? MoviesEntity(page: 0, results: [], totalPages: 0, totalResults: 0)
    }
    
    func getSeriesData() -> SeriesEntity {
        return seriesEntity ?? SeriesEntity(page: 0, results: [], totalPages: 0, totalResults: 0)
    }
    
    func setMoviesData(moviesEntity: MoviesEntity) {
        self.moviesEntity = moviesEntity
    }
    
    
    func setSeriesData(seriesEntity: SeriesEntity) {
        self.seriesEntity = seriesEntity
    }
    
    func setMoviesDataSource(moviesDataSource: MoviesCollectionViewDataSource) {
        self.moviesDataSource = moviesDataSource
    }
    
    func setSeriesDataSource(seriesDataSource: SeriesCollectionViewDataSource) {
        self.seriesDataSource = seriesDataSource
    }
    
}
