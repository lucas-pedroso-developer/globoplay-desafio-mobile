//
//  APIRoute.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 29/07/23.
//

import Foundation

enum APIRoute {
    
    // MARK: - URLs
    
    static var moviesURL: URL? {
        return URL(string: "https://api.themoviedb.org/3/movie/popular")
    }
    
    static var seriesURL: URL? {
        return URL(string: "https://api.themoviedb.org/3/tv/popular")
    }
    
    // MARK: - API Key
    
    static var apiKey: String {
        return "Bearer 9c533054f3463670421676bacdb1966b"
    }
}
