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
    
    // MARK: - Initializer
    
    required init(_ feed: Feed?) {
        self.feed = feed
    }
    
    // MARK: - Functions
    
    func getTagTypeText() -> String {
        guard let type = TagType.init(rawValue: feed?.tag ?? String()) else {
            return String()
        }
        
        return type.text
    }
    
    func getTagTypeColor() -> UIColor {
        guard let type = TagType.init(rawValue: feed?.tag ?? String()) else {
            return UIColor()
        }
        
        return type.color
    }
    
    func getTitleText() -> String {
        return feed?.title ?? String()
    }
    
    func getIsFollowing() -> Bool {
        return feed?.isFollowing ?? false
    }
    
    func getDescription() -> String? {
        return feed?.postDescription
    }
    
    func getImagesURL() -> [String] {
        var urlString: [String] = []
        feed?.images.forEach { urlString.append($0.imageUrl) }
        
        return urlString
    }
    
    func getFormatedDate() -> String {
        return feed?.lastPostDate.getFormatedDate() ?? String()
    }
}
