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
    func fetchData(completion: @escaping ((FeedResult?, String?) -> Void)) {
        cancelAllOperations()
        let feedDataOperation = FeedDataOperation(business)
        feedDataOperation.completionBlock = {
            DispatchQueue.main.async {
                let result = feedDataOperation.feedResult
                let errorMessage = feedDataOperation.errorMessage
                completion(result, errorMessage)
            }
        }
        addOperation(feedDataOperation)
    }

    func cancelOperations() {
        cancelAllOperations()
    }
}
