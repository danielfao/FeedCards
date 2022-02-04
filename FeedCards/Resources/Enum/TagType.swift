//
//  TagType.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

import UIKit

enum TagType: String {
    case recommended
    case new_arrivals
    case other
    
    var text: String {
        switch self {
        case .recommended:
            return LocalizableStrings.recommendedSeller.localized
        case .new_arrivals:
            return LocalizableStrings.newArrivals.localized
        case .other:
            return LocalizableStrings.other.localized
        }
    }
    
    var color: UIColor {
        switch self {
        case .recommended:
            return UIColor.systemGray
        case .new_arrivals:
            return UIColor.systemGreen
        case .other:
            return UIColor.systemTeal
        }
    }
}
