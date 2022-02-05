//
//  FeedCardsViewModelCellProtocol.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 04/02/22.
//

import UIKit

protocol FeedCardsModelViewCellProtocol {
    
    // MARK: - Properties
    
    var feed: Feed? { get }
    
    // MARK: - Computed properties
    
    var tagTypeText: String { get }
    var tagTypeColor: UIColor { get }
    var titleText: String { get }
    var isFollowing: Bool { get }
    var description: String? { get }
    var imagesURL: [String] { get }
    var imagesId: [String] { get }
    var formatedDate: String { get }
}
