//
//  FeedManagerProtocol.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

protocol FeedManagerProtocol {
    
    // MARK: - Functions
    
    func fetchData(completion: @escaping FeedResultCompletion)
}
