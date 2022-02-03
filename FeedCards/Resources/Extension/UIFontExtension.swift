//
//  UIFontExtension.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 03/02/22.
//

import UIKit

extension UIFont {
    
    // MARK: - Default Sizes
    
    static func defaultRegularFont() -> UIFont {
        return UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
    static func defaultMediumFont() -> UIFont {
        return UIFont.systemFont(ofSize: 12, weight: .medium)
    }
    
    static func defaultSemiBoldFont() -> UIFont {
        return UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
    
    // MARK: - Big Sizes
    
    static func bigRegularFont() -> UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    static func bigBoldFont() -> UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .bold)
    }
}
