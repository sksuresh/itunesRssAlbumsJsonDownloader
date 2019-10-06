//
//  AlbumDetailsViewModelUnitTest.swift
//  iTueneAlbumsTests
//
//  Created by Suresh Dokula on 10/6/19.
//  Copyright © 2019 suresh. All rights reserved.
//

import XCTest

class AlbumDetailsViewModelUnitTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testImgDownloadForAlbum() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var viewModel =  AlbumDetailsViewModel(album: nil, imageCache: MockDataManager.imageCache,delegate: nil)
        MockDataManager().getFeeds { (feed:Feeds?, responseResult:ResponseResult?) in
            XCTAssertNotNil(feed, "Feeds Should not be empty")
            XCTAssertNotNil(feed?.feed, "Feed Should not be empty")
            XCTAssertNotNil(feed?.feed?.results, "results Should not be empty")
            XCTAssertNotNil(feed?.feed?.results?.first, "Album Should not be empty")
            XCTAssertNotNil(feed?.feed?.results?.first?.genres, "geners Should not be empty")
            viewModel.album = feed?.feed?.results?.first
            XCTAssertNotNil(feed?.feed?.results?.first?.artworkUrl100, "img url Should not be empty")
            viewModel.getImage(imgUrl:feed?.feed?.results?.first?.artworkUrl100 ?? "", completion: { (data:Data?) in
                XCTAssertNotNil(data, "img data Should not be empty")
            })
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
