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

    // MARK: - Properties

    var feedResult: FeedResult?
    var errorMessage: String?

    // MARK: - Initializers

    init(_ business: ImagesBusinessProtocol?) {
        self.business = business
    }

    // MARK: - Override

    override func main() {
        guard !isCancelled else { return }

        business?.fetchData(completion: { result, errorMessage in
            self.feedResult = result
            self.errorMessage = errorMessage
            self.finish()
        })
    }
}
