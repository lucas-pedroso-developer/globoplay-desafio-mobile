//
//  File.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 29/07/23.
//

protocol HomeUseCaseProtocol {
    func getMovies(completion: @escaping (Result<MoviesEntity, HttpError>) -> Void)
    func getSeries(completion: @escaping (Result<SeriesEntity, HttpError>) -> Void)
}

class HomeUseCase: HomeUseCaseProtocol {
    private let homeRepository: HomeRepositoryProtocol

    init(homeRepository: HomeRepositoryProtocol) {
        self.homeRepository = homeRepository
    }

    // MARK: - Movies
    
    func getMovies(completion: @escaping (Result<MoviesEntity, HttpError>) -> Void) {
        homeRepository.getMovies() { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Series
    
    func getSeries(completion: @escaping (Result<SeriesEntity, HttpError>) -> Void) {
        homeRepository.getSeries() { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
