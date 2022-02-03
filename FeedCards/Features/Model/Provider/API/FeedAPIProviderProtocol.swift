//
//  FeedAPIProviderProtocol.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

import UIKit

protocol FeedAPIProviderProtocol {
    func fetchData(completion: @escaping (Result<FeedResult, NetworkError>) -> Void)
}
