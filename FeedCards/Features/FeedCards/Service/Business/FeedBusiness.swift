//
//  FeedBusiness.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

import UIKit

final class FeedBusiness {
    
    // MARK: - Private properties
    
    private var provider: FeedAPIProviderProtocol?
    
    init(provider: FeedAPIProviderProtocol = FeedAPIProviderMock(file: "response_feed_mock")) {
        self.provider = provider
    }
    
    private func erroMessage(_ error: NetworkError) -> String {
        switch error {
        case .invalidUrl:
            return LocalizableStrings.invalidUrlError.localized
        default:
            return LocalizableStrings.genericError.localized
        }
    }
}

// MARK: - ImagesBusinessProtocol

extension FeedBusiness: FeedBusinessProtocol {
    func fetchData(completion: @escaping FeedResultCompletion) {
        provider?.fetchData(completion: { result in
            switch result {
            case let .success(feedResult):
                completion(.success(feedResult))
            case let .failure(error):
                completion(.failure(error))
            }
        })
    }
}
