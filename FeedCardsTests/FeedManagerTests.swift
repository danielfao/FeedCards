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
    
    // MARK: - Setup
    
    var provider: FeedAPIProviderMock?
    var business: FeedBusiness?
    var manager: FeedManager?
    var feeds: [Feed] = []
    
    override func setUp() {
        super.setUp()
        
        provider = FeedAPIProviderMock(file: "response_feed_mock_test")
        business = FeedBusiness(provider: provider!)
        manager = FeedManager(business: business!)
    }
    
    // MARK: - Tests
    
    func testManagerSuccessedFetchOneData() {
        let expectation = self.expectation(description: "fetching feed data")
        manager?.fetchData(completion: { [weak self] result in
            switch result {
            case .success(let feedResult):
                self?.feeds = feedResult.feed
                expectation.fulfill()
            case .failure(_ ):
                break
            }
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(feeds.count, 1, "Feed count should be amount of 1")
    }
    
    func testManagerDataFetched() {
        let expectation = self.expectation(description: "fetching feed data")
        manager?.fetchData(completion: { [weak self] result in
            switch result {
            case .success(let feedResult):
                self?.feeds = feedResult.feed
                expectation.fulfill()
            case .failure(_ ):
                break
            }
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        
        feeds.forEach { feed in
            print(feed)
            print(mockedFeed)
            XCTAssertEqual(feed.tag, mockedFeed.tag, "feed.tag function should return the tag: \(String(describing: mockedFeed.tag))")
            XCTAssertEqual(feed.title, mockedFeed.title, "feed.title function should return the title: \(String(describing: mockedFeed.title))")
            XCTAssertEqual(feed.isFollowing, mockedFeed.isFollowing, "feed.isFollowing function should return the bool: \(String(describing: mockedFeed.isFollowing))")
            XCTAssertEqual(feed.images.count, mockedFeed.images.count, "feed.images.count function should return the counter: \(String(describing: mockedFeed.images.count))")
            XCTAssertEqual(feed.postDescription, mockedFeed.postDescription, "feed.postDescription function should return the postDescription: \(String(describing: mockedFeed.postDescription))")
            XCTAssertEqual(feed.lastPostDate, mockedFeed.lastPostDate, "feed.lastPostDate function should return the lastPostDate: \(String(describing: mockedFeed.lastPostDate))")
        }
    }
}
