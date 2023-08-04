//
//  UIImageView+Extension.swift
//  globoplay-desafio-mobile
//
//  Created by Lucas Daniel on 04/08/23.
//

import Foundation
import UIKit

// MARK: - UIImageView Extension

extension UIImageView {
    func loadImage(from url: URL) {
        self.image = UIImage(named: "placeholderImage")
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)),
           let image = UIImage(data: cachedResponse.data) {
            self.image = image
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print("Erro ao baixar a imagem: \(error?.localizedDescription ?? "Erro desconhecido")")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.image = image
                    
                    let cachedResponse = CachedURLResponse(response: response, data: data)
                    URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
                }
            }
        }.resume()
    }
}
