//
//  FeedManagerProtocol.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

import UIKit

protocol FeedManagerProtocol {
    
    // MARK: - Functions
    
    func fetchData(completion: @escaping FeedResultCompletion)
    func cancelOperations()
}
