//
//  LocalizableStrings.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 03/02/22.
//

enum LocalizableStrings: String, Localizable {
    // MARK: - Tag type
    
    case recommendedSeller
    case newArrivals
    case other
    case ok
    
    // MARK: - Feed
    
    case feedTitle
    
    // MARK: - Defaults
    
    case followButtonTitle
    case shareButtonTitle
    
    // MARK: - Network messages
    
    case invalidUrlError
    case genericError
    
    // MARK: - Date messages
    
    case postedToday
    case postedAnotherDay
    
    // MARK: - Alert

    case alertImageMessage
    case alertImageTitle
    case alertShareMessage
    case alertShareTitle
    case alertFollowMessage
    case alertFollowTitle
    
    // MARK: - Computed Propertie
    
    var localized: String {
        self.rawValue.localized
    }
    
    // MARK: - Public function
    
    static func get(_ value: LocalizableStrings) -> String {
        value.localized
    }
}
