//
//  FeedDataOperation.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

import Foundation

class FeedDataOperation: AsyncOperation {
    // MARK: - Private properties

    private var business: ImagesBusinessProtocol?
    private var completion: FeedResultCompletion?

    // MARK: - Initializers

    init(_ business: ImagesBusinessProtocol?, completion: @escaping FeedResultCompletion) {
        self.business = business
        self.completion = completion
    }

    // MARK: - Override

    override func main() {
        guard !isCancelled else { return }

        business?.fetchData(completion: { [weak self] result in
            switch result {
            case .success(let feedResult):
                self?.completion?(.success(feedResult))
            case .failure(let error):
                self?.completion?(.failure(error))
            }
            
            self?.finish()
        })
    }
}
