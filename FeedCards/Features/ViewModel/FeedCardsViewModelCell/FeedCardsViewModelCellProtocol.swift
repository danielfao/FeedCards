//
//  FeedCardsViewModelCellProtocol.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 04/02/22.
//

import UIKit

protocol FeedCardsViewModelCellProtocol {
    
    // MARK: - Properties
    
    var feed: Feed? { get }
    
    // MARK: - Computed properties
    
    var getTagTypeText: String { get }
    var getTagTypeColor: UIColor { get }
    var getTitleText: String { get }
    var getIsFollowing: Bool { get }
    var getDescription: String? { get }
    var getImagesURL: [String] { get }
    var getFormatedDate: String { get }
}
