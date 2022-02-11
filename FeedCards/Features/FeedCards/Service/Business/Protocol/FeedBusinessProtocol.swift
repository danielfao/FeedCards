//
//  FeedBusinessProtocol.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

typealias FeedResultCompletion = (Result<FeedResult, NetworkError>) -> Void

protocol FeedBusinessProtocol {
    
    // MARK: - Functions
    
    func fetchData(completion: @escaping FeedResultCompletion)
}
