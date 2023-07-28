//
//  SeriesData.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 28/07/23.
//

import Foundation

struct SeriesData: Codable {
    let backdropPath: String?
    let firstAirDate: String
    let genreIds: [Int]
    let id: Int
    let name: String
    let originCountry: [String]
    let originalLanguage: String
    let originalName: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case backdropPath
        case firstAirDate
        case genreIds
        case id
        case name
        case originCountry
        case originalLanguage
        case originalName
        case overview
        case popularity
        case posterPath
        case voteAverage
        case voteCount
    }
}
