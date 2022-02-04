//
//  FeedCardsViewModelCellTests.swift
//  FeedCardsTests
//
//  Created by Daniel Oliveira on 04/02/22.
//

@testable import FeedCards
import XCTest

class FeedCardsViewModelCellTests: XCTestCase {
    
    // MARK: - Mocked constants
    
    private var feeds = Feed(tag: "recommended", isFollowing: true, title: "Seller with a very long name that needs two line to fit", images: [
        Image(id: "30", imageUrl: "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTN8fHxlbnwwfHx8fA%3D%3D&w=1000&q=80"),
        Image(id: "31", imageUrl: "https://blog-www.pods.com/wp-content/uploads/2020/07/Feature-Home-Office-GEtty-Resized.jpg"),
        Image(id: "32", imageUrl: "https://www.beach.com/wp-content/uploads/2019/04/rsz_shutterstock_377796004-680x380.jpg")
    ], postDescription: "Something beatutiful and cute", lastPostDate: "2021-12-02T13:45:00.000Z")
    
    let urlStrings = [
        "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTN8fHxlbnwwfHx8fA%3D%3D&w=1000&q=80",
        "https://blog-www.pods.com/wp-content/uploads/2020/07/Feature-Home-Office-GEtty-Resized.jpg",
        "https://www.beach.com/wp-content/uploads/2019/04/rsz_shutterstock_377796004-680x380.jpg"
    ]
    
    let postDescription = "Something beatutiful and cute"
    let datePhraseString = "Posted on:"
    let titleString = "Seller with a very long name that needs two line to fit"
    
    private var viewModel: FeedCardsViewModelCell?
    
    func testGetImagesURLFunction() {
        viewModel = FeedCardsViewModelCell(feeds)
        
        guard let viewModel = viewModel else {
            return
        }
        
        let urlString = viewModel.getImagesURL()
        XCTAssertNotNil(urlString, "getImagesURL function should not be nil")
        XCTAssertTrue(urlString == urlStrings, "getImagesURL function should return \(urlStrings)")
    }
    
    func testGetTitleText() {
        viewModel = FeedCardsViewModelCell(feeds)
        
        guard let viewModel = viewModel else {
            return
        }
        
        let stringTitle = viewModel.getTitleText()
        XCTAssertNotNil(stringTitle, "getTagTypeText function should not be nil")
        XCTAssertTrue(stringTitle == titleString, "getTitleText function should return \(titleString)")
    }
    
    func testGetDescriptionFunction() {
        viewModel = FeedCardsViewModelCell(feeds)
        
        guard let viewModel = viewModel else {
            return
        }
        
        let descriptionText = viewModel.getDescription()
        XCTAssertNotNil(descriptionText, "getDescription function should not be nil")
        XCTAssertTrue(descriptionText == postDescription, "getDescription function should return \(postDescription)")
    }
    
    func testGetFormatedData() {
        viewModel = FeedCardsViewModelCell(feeds)
        
        guard let viewModel = viewModel else {
            return
        }
        
        let dateString = viewModel.getFormatedDate()
        XCTAssertNotNil(dateString, "getFormatedDate function should not be nil")
        XCTAssertTrue(dateString.contains(datePhraseString), "getFormatedDate function should return the sentence \(datePhraseString) and the date of the post")
    }
    
    func testTagTypeTextFunction() {
        viewModel = FeedCardsViewModelCell(feeds)
        
        guard let viewModel = viewModel else {
            return
        }
        
        let tagTypeString = viewModel.getTagTypeText()
        XCTAssertNotNil(tagTypeString, "getTagTypeText function should not be nil")
        XCTAssertTrue(tagTypeString == TagType.recommended.text, "getTagTypeText function should return \(TagType.recommended.text)")
    }
    
    func testTagTypeColorFunction() {
        viewModel = FeedCardsViewModelCell(feeds)
        
        guard let viewModel = viewModel else {
            return
        }
        
        let tagTypeColor = viewModel.getTagTypeColor()
        XCTAssertNotNil(tagTypeColor, "getTagTypeColor function should not be nil")
        XCTAssertTrue(tagTypeColor == UIColor.systemGray, "getTagTypeText function should return \(TagType.recommended.color)")
    }
    
    func testGetIsFollowingFunction() {
        viewModel = FeedCardsViewModelCell(feeds)
        
        guard let viewModel = viewModel else {
            return
        }
        
        let isFollowing = viewModel.getIsFollowing()
        XCTAssertNotNil(isFollowing, "getIsFollowing function should not be nil")
        XCTAssertTrue(isFollowing, "getIsFollowing function should return true")
    }
}
