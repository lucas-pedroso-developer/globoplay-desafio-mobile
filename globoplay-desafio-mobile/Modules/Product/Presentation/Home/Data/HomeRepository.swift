//
//  HomeRepository.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 29/07/23.
//

import Foundation

protocol HomeRepositoryProtocol {
    func getMovies(completion: @escaping (Result<MoviesEntity, HttpError>) -> Void)
    func getSeries(completion: @escaping (Result<SeriesEntity, HttpError>) -> Void)
}

class HomeRepository: HomeRepositoryProtocol {

    let network: HttpGetClient
    
    init(network: HttpGetClient) {
        self.network = network
    }
    
    // MARK: - Exchanges
    
    func getMovies(completion: @escaping (Result<MoviesEntity, HttpError>) -> Void) {
        network.get(url: getMoviesURL()) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let dataUnwraped = data else { return completion(.failure(.noData)) }
                do {
                    let moviesEntity = try JSONDecoder().decode(MoviesEntity.self, from: dataUnwraped)
                    completion(.success(moviesEntity))
                } catch {
                    completion(.failure(.decodeError))
                }
            }
        }
    }
    
    // MARK: - Icons
    
    func getSeries(completion: @escaping (Result<SeriesEntity, HttpError>) -> Void) {
        network.get(url: getSeriesURL()) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let dataUnwraped = data else { return completion(.failure(.noData)) }
                do {
                    let seriesEntity = try JSONDecoder().decode(SeriesEntity.self, from: dataUnwraped)
                    completion(.success(seriesEntity))
                } catch {
                    completion(.failure(.decodeError))
                }
            }
        }
    }
    
    // MARK: - Private Helpers
    
    private func getMoviesURL() -> URL? {
        return APIRoute.moviesURL
    }
    
    private func getSeriesURL() -> URL? {
        return APIRoute.seriesURL
    }
}
