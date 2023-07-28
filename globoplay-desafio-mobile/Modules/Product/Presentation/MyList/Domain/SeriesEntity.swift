//
//  SeriesEntity.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 28/07/23.
//

import Foundation

struct SeriesEntity: Codable {
    let page: Int
    let results: [SeriesData]
    let totalPages: Int
    let totalResults: Int
}
