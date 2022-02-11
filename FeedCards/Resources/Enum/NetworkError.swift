//
//  NetworkError.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
    case unableToComplete
    case unableToParse
}
