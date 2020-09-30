//
//  FeedViewControllerTests.swift
//  Fast NewsTests
//
//  Created by Afonso Lucas on 30/09/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import XCTest
@testable import Fast_News

class FeedViewControllerTests: XCTestCase {

    var mockService: HotNewsProviderProtocol?
    var sut: FeedViewController?
    
    override func setUp() {
        super.setUp()
        
        mockService = HotNewsProviderMock.shared
        sut = UIStoryboard(name: "Feed", bundle: nil).instantiateViewController(withIdentifier: "FeedViewController") as? FeedViewController
        
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
        XCTAssertEqual(sut?.hotNews.count, 0)
    }
    
    func testFetchSuccess() {
        mockService?.environment = .testing(result: .success)
        sut?.hotNewsProvider = mockService!
        sut?.loadViewIfNeeded()
        XCTAssertNotEqual(sut?.hotNews.count, 0)
    }
    
}
