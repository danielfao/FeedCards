//
//  FeedManagerTests.swift
//  FeedCardsTests
//
//  Created by Daniel Oliveira on 04/02/22.
//

@testable import FeedCards
import XCTest

class FeedManagerTests: XCTestCase {
    // MARK: - Mocked constants
    
    private let mockedFeed = Feed(
        tag: "recommendd",
        isFollowing: true,
        title: "eller with a very long name that needs two line to fit",
        images: [
            Image(id: "10", imageUrl: "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTN8fHxlbnwwfHx8fA%3D%3D&w=1000&q=80"),
            Image(id: "11", imageUrl: "https://blog-www.pods.com/wp-content/uploads/2020/07/Feature-Home-Office-GEtty-Resized.jpg"),
            Image(id: "12", imageUrl: "https://www.beach.com/wp-content/uploads/2019/04/rsz_shutterstock_377796004-680x380.jpg")
        ],
        postDescription: "Just in! New items from Jerseygramm and Brandings available. Check them ou1!",
        lastPostDate: "2021-02-03T13:45:00.000Z")
    
    let urlStrings = [
        "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTN8fHxlbnwwfHx8fA%3D%3D&w=1000&q=80",
        "https://blog-www.pods.com/wp-content/uploads/2020/07/Feature-Home-Office-GEtty-Resized.jpg",
        "https://www.beach.com/wp-content/uploads/2019/04/rsz_shutterstock_377796004-680x380.jpg"
    ]
    
    // MARK: - Tests
    
    func testManagerSuccessedFetchData() {
        let provider = FeedAPIProviderMock(file: "response_feed_mock_test")
        let business = ImagesBusiness(provider: provider)
        let manager = FeedManager(business: business)
        
        var feed: [Feed] = []
        
        manager.fetchData(completion: { result in
            switch result {
            case .success(let feedResult):
                feed = feedResult.feed
            case .failure(_ ):
                break
            }
        })
        
        DispatchQueue.main.async {
            XCTAssert(feed.count == 1)
        }
    }
    
    func testManagerDataFetched() {
        let provider = FeedAPIProviderMock(file: "response_feed_mock_test")
        let business = ImagesBusiness(provider: provider)
        let manager = FeedManager(business: business)
        
        var feeds: [Feed] = []
        
        manager.fetchData(completion: { result in
            switch result {
            case .success(let feedResult):
                feeds = feedResult.feed
            case .failure(_ ):
                break
            }
        })
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            for feed in feeds {
                print(feed)
                print(self.mockedFeed)
                XCTAssertFalse(feed.tag == self.mockedFeed.tag, "feed.tag function should return the tag: \(String(describing: self.mockedFeed.tag))")
                XCTAssertTrue(feed.title == self.mockedFeed.title, "feed.title function should return the title: \(String(describing: self.mockedFeed.title))")
                XCTAssertTrue(feed.isFollowing == self.mockedFeed.isFollowing, "feed.isFollowing function should return the bool: \(String(describing: self.mockedFeed.isFollowing))")
                XCTAssertTrue(feed.images.count == self.mockedFeed.images.count, "feed.images.count function should return the counter: \(String(describing: self.mockedFeed.images.count))")
                XCTAssertTrue(feed.postDescription == self.mockedFeed.postDescription, "feed.postDescription function should return the postDescription: \(String(describing: self.mockedFeed.postDescription))")
                XCTAssertTrue(feed.lastPostDate == self.mockedFeed.lastPostDate, "feed.lastPostDate function should return the lastPostDate: \(String(describing: self.mockedFeed.lastPostDate))")
            }
        }
    }
}
