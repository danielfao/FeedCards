//
//  LocalizableStrings.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 03/02/22.
//

import Foundation

enum LocalizableStrings: String, Localizable {
    // MARK: - Tag type
    
    case recommendedSeller
    case newArrivals
    case other
    
    // MARK: - Feed
    
    case feedTitle
    
    // MARK: - Defaults
    
    case followButtonTitle
    case shareButtonTitle
    
    // MARK: - Computed Propertie
    
    var localized: String {
        self.rawValue.localized
    }
    
    // MARK: - Public function
    
    static func get(_ value: LocalizableStrings) -> String {
        value.localized
    }
}
