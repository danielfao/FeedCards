//
//  FeedAPIProvider.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

import UIKit

struct FeedAPIProvider: FeedAPIProviderProtocol {
    // MARK: - Functions
    
    func fetchData(_ urlString: String?, completion: @escaping FeedResultCompletion) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let search = try JSONDecoder().decode(FeedResult.self, from: data)
                completion(.success(search))
            } catch {
                completion(.failure(.unableToParse))
            }
        }
        task.resume()
    }
    
    func downloadImage(image: Image, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let url = URL(string: image.imageUrl) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.downloadTask(with: url) { location, _, _ in
            if let locationUrl = location, let data = try? Data(contentsOf: locationUrl) {
                if let image = UIImage(data: data) {
                    completion(.success(image))
                    return
                }
            }
            completion(.failure(.unableToComplete))
        }
        task.resume()
    }
}
