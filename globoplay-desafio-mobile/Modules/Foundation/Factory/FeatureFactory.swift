//
//  FeatureFactory.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 29/07/23.
//

import UIKit

// MARK: - FeatureFactory

protocol FeatureFactory {
    associatedtype Dependencies
    static func make(with dependencies: Dependencies) -> HomeViewModelProtocol
}
