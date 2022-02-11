//
//  FeedCardsViewModel.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 09/12/21.
//

class FeedCardsViewModel: FeedCardsViewModelProtocol {
    
    // MARK: - Public properties
    
    var feed: [Feed] = []
    
    // MARK: - Private properties
    
    private var manager: FeedManagerProtocol
    
    // MARK: - Initializer
    
    required init(_ manager: FeedManagerProtocol = FeedManager()) {
        self.manager = manager
    }
    
    // MARK: - Public functions
    
    func fetchData() {
        manager.fetchData { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let feedResult):
                self.feed = feedResult.feed
            case .failure(let error):
                print(error)
            }
        }
    }
}
