//
//  FeedAPIProviderProtocol.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

protocol FeedAPIProviderProtocol {
    func fetchData(_ urlString: String?, completion: @escaping FeedResultCompletion)
}
