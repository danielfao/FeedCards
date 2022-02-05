//
//  CGFloatExtension.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 03/02/22.
//

import UIKit

// MARK: - Spacing enumeration

enum Size: CGFloat {
    case tine = 4.0
    case xSmall = 8.0
    case small = 10.0
    case xMedium = 12.0
    case medium = 16.0
    case big = 24.0
    case huge = 100.0
}

// MARK: - CGFloat extension

extension CGFloat {
    
    /// Method responsible for get a default spacing
    /// - Parameter size: Spacing size
    static func spacing(_ size: Size) -> CGFloat {
        return size.rawValue
    }
    
    /// Method responsible for get a default size
    /// - Parameter size: Spacing size
    static func size(_ size: Size) -> CGFloat {
        return size.rawValue
    }
}
