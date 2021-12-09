//
//  FeedResult.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

import Foundation

// MARK: - Feed Result

struct FeedResult: Codable {
    let feed: [Feed]
}

// MARK: - Feed

struct Feed: Codable {
    let tag: String
    let isFollowing: Bool
    let title: String
    let images: [Image]
    let postDescription: String?
    let lastPostDate: String
}

// MARK: - Image

struct Image: Codable {
    let id: String
    let imageUrl: String
}
