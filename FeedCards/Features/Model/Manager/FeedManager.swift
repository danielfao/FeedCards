//
//  FeedManager.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

import UIKit

final class FeedManager: OperationQueue {
    
    // MARK: - Constants

    private let cache = NSCache<NSString, UIImage>()
    
    // MARK: - Private properties
    
    private var business: ImagesBusinessProtocol?
    
    init(business: ImagesBusinessProtocol? = ImagesBusiness()) {
        self.business = business
    }
}

// MARK: - FeedManagerProtocol

extension FeedManager: FeedManagerProtocol {
    func fetchData(completion: @escaping FeedResultCompletion) {
        cancelAllOperations()
        let feedDataOperation = FeedDataOperation(business) { result in
            switch result {
            case .success(let feedResult):
                completion(.success(feedResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        addOperation(feedDataOperation)
    }

    func cancelOperations() {
        cancelAllOperations()
    }
}
