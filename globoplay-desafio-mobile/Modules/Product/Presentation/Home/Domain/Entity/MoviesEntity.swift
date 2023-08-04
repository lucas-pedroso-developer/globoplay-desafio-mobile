//
//  MoviesEntity.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 28/07/23.
//

import Foundation

struct MoviesEntity: Codable {
    let page: Int
    let results: [MoviesData]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
