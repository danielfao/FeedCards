//
//  FeedCardsViewModelTests.swift
//  FeedCardsTests
//
//  Created by Daniel Oliveira on 09/12/21.
//

@testable import FeedCards
import XCTest

class FeedCardsViewModelTests: XCTestCase {
    
    // MARK: - Constants to test
    
    let urlStrings = [
        "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTN8fHxlbnwwfHx8fA%3D%3D&w=1000&q=80",
        "https://blog-www.pods.com/wp-content/uploads/2020/07/Feature-Home-Office-GEtty-Resized.jpg",
        "https://www.beach.com/wp-content/uploads/2019/04/rsz_shutterstock_377796004-680x380.jpg"
    ]
    
    let postDescription = "Something beatutiful and cute"
    let datePhraseString = "Posted on:"
    let titleString = "Seller with a very long name that needs two line to fit"
    
    private var feeds = Feed(tag: "recommended", isFollowing: true, title: "Seller with a very long name that needs two line to fit", images: [
        Image(id: "30", imageUrl: "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTN8fHxlbnwwfHx8fA%3D%3D&w=1000&q=80"),
        Image(id: "31", imageUrl: "https://blog-www.pods.com/wp-content/uploads/2020/07/Feature-Home-Office-GEtty-Resized.jpg"),
        Image(id: "32", imageUrl: "https://www.beach.com/wp-content/uploads/2019/04/rsz_shutterstock_377796004-680x380.jpg")
    ], postDescription: "Something beatutiful and cute", lastPostDate: "2021-12-02T13:45:00.000Z")
    
    private var viewModel: FeedCardsViewModelProtocol?
    
    // MARK: - Tests
    
    func testGetImagesURLFunction() {
        viewModel = FeedCardsViewModel(feeds)
        
        guard let viewModel = viewModel else {
            return
        }
        
        let urlString = viewModel.getImagesURL()
        XCTAssertNotNil(urlString, "getImagesURL function should not be nil")
        XCTAssertTrue(urlString == urlStrings, "getImagesURL function should return \(urlStrings)")
    }
    
    func testSetTitleText() {
        viewModel = FeedCardsViewModel(feeds)
        
        guard let viewModel = viewModel else {
            return
        }
        
        let stringTitle = viewModel.setTitleText()
        XCTAssertNotNil(stringTitle, "setTagTypeText function should not be nil")
        XCTAssertTrue(stringTitle == titleString, "setTitleText function should return \(titleString)")
    }
    
    func testSetDescriptionFunction() {
        viewModel = FeedCardsViewModel(feeds)
        
        guard let viewModel = viewModel else {
            return
        }
        
        let descriptionText = viewModel.setDescription()
        XCTAssertNotNil(descriptionText, "setDescription function should not be nil")
        XCTAssertTrue(descriptionText == postDescription, "setDescription function should return \(postDescription)")
    }
    
    func testSetFormatedData() {
        viewModel = FeedCardsViewModel(feeds)
        
        guard let viewModel = viewModel else {
            return
        }
        
        let dateString = viewModel.setFormatedData()
        XCTAssertNotNil(dateString, "setFormatedData function should not be nil")
        XCTAssertTrue(dateString.contains(datePhraseString), "setFormatedData function should return the sentence \(datePhraseString) and the date of the post")
    }
    
    func testTagTypeTextFunction() {
        viewModel = FeedCardsViewModel(feeds)
        
        guard let viewModel = viewModel else {
            return
        }
        
        let tagTypeString = viewModel.setTagTypeText()
        XCTAssertNotNil(tagTypeString, "setTagTypeText function should not be nil")
        XCTAssertTrue(tagTypeString == TagType.recommended.text, "setTagTypeText function should return \(TagType.recommended.text)")
    }
    
    func testTagTypeColorFunction() {
        viewModel = FeedCardsViewModel(feeds)
        
        guard let viewModel = viewModel else {
            return
        }
        
        let tagTypeColor = viewModel.setTagTypeColor()
        XCTAssertNotNil(tagTypeColor, "setTagTypeColor function should not be nil")
        XCTAssertTrue(tagTypeColor == UIColor.systemGray, "setTagTypeText function should return \(TagType.recommended.color)")
    }
    
    func testSetIsFollowingFunction() {
        viewModel = FeedCardsViewModel(feeds)
        
        guard let viewModel = viewModel else {
            return
        }
        
        let isFollowing = viewModel.setIsFollowing()
        XCTAssertNotNil(isFollowing, "setIsFollowing function should not be nil")
        XCTAssertTrue(isFollowing, "setIsFollowing function should return true")
    }
}
