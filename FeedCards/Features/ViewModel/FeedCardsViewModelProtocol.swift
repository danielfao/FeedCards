//
//  FeedCardsViewModelProtocol.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

import UIKit

protocol FeedCardsViewModelProtocol {
    
    // MARK: - Properties
    
    var feed: Feed { get set }
    
    // MARK: - Functions
    
    func setTagTypeText() -> String
    func setTagTypeColor() -> UIColor
    func setTitleText() -> String
    func setIsFollowing() -> Bool
    func setDescription() -> String?
    func setFormatedData() -> String
    func getImagesURL() -> [String]
}
