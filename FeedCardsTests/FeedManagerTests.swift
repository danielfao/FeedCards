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
        tag: "recommended",
        isFollowing: false,
        title: "Seller with a very long name that needs two line to fit",
        images: [
            Image(id: "10", imageUrl: "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTN8fHxlbnwwfHx8fA%3D%3D&w=1000&q=80"),
            Image(id: "11", imageUrl: "https://blog-www.pods.com/wp-content/uploads/2020/07/Feature-Home-Office-GEtty-Resized.jpg"),
            Image(id: "12", imageUrl: "https://www.beach.com/wp-content/uploads/2019/04/rsz_shutterstock_377796004-680x380.jpg")
        ],
        postDescription: "Just in! New items from Jerseygramm and Brandings available. Check them out!",
        lastPostDate: "2022-02-03T13:45:00.000Z")
    
    let urlStrings = [
        "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTN8fHxlbnwwfHx8fA%3D%3D&w=1000&q=80",
        "https://blog-www.pods.com/wp-content/uploads/2020/07/Feature-Home-Office-GEtty-Resized.jpg",
        "https://www.beach.com/wp-content/uploads/2019/04/rsz_shutterstock_377796004-680x380.jpg"
    ]
    
    // MARK: - Tests
    
    func testManagerSuccessedFetchOneData() {
        let provider = FeedAPIProviderMock(file: "response_feed_mock_test")
        let business = FeedBusiness(provider: provider)
        let manager = FeedManager(business: business)
        
        var feed: [Feed] = []
        
        let expectation = self.expectation(description: "fetching feed data")
        manager.fetchData(completion: { result in
            switch result {
            case .success(let feedResult):
                feed = feedResult.feed
                expectation.fulfill()
            case .failure(_ ):
                break
            }
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(feed.count, 1, "Feed count should be amount of 1")
    }
    
    func testManagerDataFetched() {
        let provider = FeedAPIProviderMock(file: "response_feed_mock_test")
        let business = FeedBusiness(provider: provider)
        let manager = FeedManager(business: business)
        
        var feeds: [Feed] = []
        
        let expectation = self.expectation(description: "fetching feed data")
        manager.fetchData(completion: { result in
            switch result {
            case .success(let feedResult):
                feeds = feedResult.feed
                expectation.fulfill()
            case .failure(_ ):
                break
            }
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        
        for feed in feeds {
            print(feed)
            print(self.mockedFeed)
            XCTAssertEqual(feed.tag, self.mockedFeed.tag, "feed.tag function should return the tag: \(String(describing: self.mockedFeed.tag))")
            XCTAssertEqual(feed.title, self.mockedFeed.title, "feed.title function should return the title: \(String(describing: self.mockedFeed.title))")
            XCTAssertEqual(feed.isFollowing, self.mockedFeed.isFollowing, "feed.isFollowing function should return the bool: \(String(describing: self.mockedFeed.isFollowing))")
            XCTAssertEqual(feed.images.count, self.mockedFeed.images.count, "feed.images.count function should return the counter: \(String(describing: self.mockedFeed.images.count))")
            XCTAssertEqual(feed.postDescription, self.mockedFeed.postDescription, "feed.postDescription function should return the postDescription: \(String(describing: self.mockedFeed.postDescription))")
            XCTAssertEqual(feed.lastPostDate, self.mockedFeed.lastPostDate, "feed.lastPostDate function should return the lastPostDate: \(String(describing: self.mockedFeed.lastPostDate))")
        }
    }
}
