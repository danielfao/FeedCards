//
//  FeedCardsViewModelCellProtocol.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 04/02/22.
//

import UIKit

protocol FeedCardsViewModelCellProtocol {
    
    // MARK: - Properties
    
    var feed: Feed? { get }
    
    // MARK: - Functions
    
    func getTagTypeText() -> String
    func getTagTypeColor() -> UIColor
    func getTitleText() -> String
    func getIsFollowing() -> Bool
    func getDescription() -> String?
    func getImagesURL() -> [String]
    func getFormatedDate() -> String
}
