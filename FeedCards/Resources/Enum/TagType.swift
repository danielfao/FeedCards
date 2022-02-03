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
            return StringConstants.recommendedSeller
        case .new_arrivals:
            return StringConstants.newArrivals
        case .other:
            return StringConstants.other
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
