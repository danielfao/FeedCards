//
//  FeedCardsViewModelCell.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 04/02/22.
//

import UIKit

class FeedCardsViewModelCell: FeedCardsViewModelCellProtocol {
    
    // MARK: - Public properties
    
    var feed: Feed?
    
    // MARK: - Computed Properties
    
    var getTagTypeText: String {
        guard let type = TagType.init(rawValue: feed?.tag ?? String()) else {
            return String()
        }
        
        return type.text
    }
    
    var getTagTypeColor: UIColor {
        guard let type = TagType.init(rawValue: feed?.tag ?? String()) else {
            return UIColor()
        }
        
        return type.color
    }
    
    var getTitleText: String {
        return feed?.title ?? String()
    }
    
    var getIsFollowing: Bool {
        return feed?.isFollowing ?? false
    }
    
    var getDescription: String? {
        return feed?.postDescription
    }
    
    var getImagesURL: [String] {
        var urlString: [String] = []
        feed?.images.forEach { urlString.append($0.imageUrl) }
        
        return urlString
    }
    
    var getFormatedDate: String {
        return feed?.lastPostDate.getFormatedDate() ?? String()
    }
    
    // MARK: - Initializer
    
    required init(_ feed: Feed?) {
        self.feed = feed
    }
}
