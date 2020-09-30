//
//  FeedDetailsViewControllerTests.swift
//  Fast NewsTests
//
//  Created by Afonso Lucas on 30/09/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import XCTest
@testable import Fast_News

class FeedDetailsViewControllerTests: XCTestCase {

    var mockService: HotNewsProviderProtocol?
    var sut: FeedDetailsViewController?
    
    override func setUp() {
        super.setUp()
        
        mockService = HotNewsProviderMock.shared
        sut = UIStoryboard(name: "Feed", bundle: nil).instantiateViewController(withIdentifier: "FeedDetailsViewController") as? FeedDetailsViewController
        
    }

    override func tearDown() {
        mockService = nil
        sut = nil
        
        super.tearDown()
    }
    
    func testFetchFail() {
        mockService?.environment = .testing(result: .fail)
        sut?.hotNewsProvider = mockService!
        sut?.loadViewIfNeeded()
        XCTAssertEqual(sut?.comments.count, 0)
    }
    
    func testFetchSuccess() {
        mockService?.environment = .testing(result: .success)
        sut?.hotNewsProvider = mockService!
        sut?.loadViewIfNeeded()
        XCTAssertNotEqual(sut?.comments.count, 0)
    }

}
