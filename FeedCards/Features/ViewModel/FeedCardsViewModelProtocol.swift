//
//  FeedCardsViewModelProtocol.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

import UIKit

protocol FeedCardsViewModelProtocol {
    
    // MARK: - Properties
    
    var feed: [Feed] { get }
    
    // MARK: - Functions
    
    func fetchData()
}
