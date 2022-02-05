//
//  FeedCardsViewModelCell.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 04/02/22.
//

import UIKit

class FeedCardsModelViewCell: FeedCardsModelViewCellProtocol {
    
    // MARK: - Public properties
    
    var feed: Feed?
    
    // MARK: - Computed Properties
    
    var tagTypeText: String {
        guard let type = TagType.init(rawValue: feed?.tag ?? String()) else {
            return String()
        }
        
        return type.text
    }
    
    var tagTypeColor: UIColor {
        guard let type = TagType.init(rawValue: feed?.tag ?? String()) else {
            return UIColor()
        }
        
        return type.color
    }
    
    var titleText: String {
        return feed?.title ?? String()
    }
    
    var isFollowing: Bool {
        return feed?.isFollowing ?? false
    }
    
    var description: String? {
        return feed?.postDescription
    }
    
    var imagesURL: [String] {
        var urlString: [String] = []
        feed?.images.forEach { urlString.append($0.imageUrl) }
        
        return urlString
    }
    
    var imagesId: [String] {
        var imagesId: [String] = []
        feed?.images.forEach { imagesId.append($0.id) }
        
        return imagesId
    }
    
    var formatedDate: String {
        return feed?.lastPostDate.getFormatedDate() ?? String()
    }
    
    // MARK: - Initializer
    
    required init(with feed: Feed?) {
        self.feed = feed
    }
}
