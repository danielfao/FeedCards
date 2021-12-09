//
//  FeedCardsViewModel.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

import UIKit

class FeedCardsViewModel: FeedCardsViewModelProtocol {
    
    // MARK: - Public properties
    
    var feed: Feed
    
    // MARK: - Private properties
    
    private var manager: FeedManagerProtocol?
    private var feedImages: [UIImage]? = []
    
    // MARK: - Initializer
    
    required init(_ feed: Feed, _ manager: FeedManagerProtocol? = FeedManager()) {
        self.feed = feed
        self.manager = manager
    }
    
    // MARK: - Public functions
    
    func setTagTypeText() -> String {
        guard let type = TagType.init(rawValue: feed.tag) else {
            return String()
        }
        
        return type.text
    }
    
    func setTagTypeColor() -> UIColor {
        guard let type = TagType.init(rawValue: feed.tag) else {
            return UIColor()
        }
        
        return type.color
    }
    
    func setTitleText() -> String {
        return feed.title
    }
    
    func setIsFollowing() -> Bool {
        return feed.isFollowing
    }
    
    func setDescription() -> String? {
        return feed.postDescription
    }
    
    func getImagesURL() -> [String] {
        var urlString: [String] = []
        for image in feed.images {
            urlString.append(image.imageUrl)
        }
        return urlString
    }
    
    func setFormatedData() -> String {
        var dateFormatted = String()
        let lastPostDate = feed.lastPostDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        if let postDate = dateFormatter.date(from: lastPostDate) {
            let currentDate = Date()
            let delta = postDate.timeIntervalSince(currentDate)
            if delta < .zero {
                let dayFormatter = DateComponentsFormatter()
                dayFormatter.allowedUnits = [.day]
                
                let timeFormatter = DateFormatter()
                timeFormatter.timeZone = .current
                
                guard let dayString = dayFormatter.string(from: delta), let consecutiveDays = Int(dayString.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted)) else { return String() }
                if consecutiveDays > .zero {
                    timeFormatter.dateFormat = "dd-MM-yyyy"
                    timeFormatter.string(from: currentDate)
                    let date = timeFormatter.string(from: currentDate)
                    dateFormatted = "Posted on: \(date)"
                } else {
                    timeFormatter.timeStyle = .short
                    let time = timeFormatter.string(from: postDate)
                    dateFormatted = "Posted today at: \(time)"
                }
            }
        }
        return dateFormatted
    }
}
