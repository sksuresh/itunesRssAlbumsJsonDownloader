//
//  AlbumViewModelUnitTest.swift
//  iTueneAlbumsTests
//
//  Created by Suresh Dokula on 10/6/19.
//  Copyright © 2019 suresh. All rights reserved.
//

import XCTest

class AlbumViewModelUnitTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFailDownloadFeeds() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let dataManager = MockDataManager()
        dataManager.responseStatus = .fail
       var viewModel =  AlbumViewModel(feed: nil, imageCache: MockDataManager.imageCache, delegate: nil,dataManager:dataManager)
        viewModel.jsonParsing { (result:DataFetchStatus?) in
            switch result {
            case .success(let feed)?:
                XCTAssertNil(feed, "Feeds Should  be empty")
                XCTAssertNil(feed?.feed, "Feed Should  be empty")
                XCTAssertNil(feed?.feed?.results, "results Should  be empty")
                XCTAssertNil(feed?.feed?.links, "links Should  be empty")
                XCTAssertNil(feed?.feed?.author, "author Should  be empty")
                XCTAssertNil(feed?.feed?.results?.first?.genres, "geners Should  be empty")
            case .fail(let error)?:
                XCTAssertNotNil(error, "Error should  not be nil")
            case .none:
                break
            }
         
        }
    }
    
    func testDownloadFeeds() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var viewModel =  AlbumViewModel(feed: nil, imageCache: MockDataManager.imageCache, delegate: nil, dataManager: MockDataManager())
        viewModel.jsonParsing {  (result:DataFetchStatus?) in
            switch result {
            case .success(let feed)?:
                XCTAssertNotNil(feed, "Feeds Should not be empty")
                XCTAssertNotNil(feed?.feed, "Feed Should not be empty")
                XCTAssertNotNil(feed?.feed?.results, "results Should not be empty")
                XCTAssertNotNil(feed?.feed?.links, "links Should not be empty")
                XCTAssertNotNil(feed?.feed?.author, "author Should not be empty")
                XCTAssertNotNil(feed?.feed?.results?.first?.genres, "geners Should not be empty")
            case .fail(let error)?:
                XCTAssertNotNil(error, "Error should not be nil")
            case .none:
                break
            }
        }
    }
    
    func testImgDownloadForAlbum(){
        var viewModel =  AlbumViewModel(feed: nil, imageCache: MockDataManager.imageCache, delegate: nil, dataManager: MockDataManager())
        viewModel.jsonParsing { (result:DataFetchStatus?) in
            switch result {
            case .success(let feed)?:
                XCTAssertNotNil(feed?.feed?.results?.first?.artworkUrl100, "img url Should not be empty")
                DispatchQueue.main.async{
                viewModel.getImage(imgUrl:feed?.feed?.results?.first?.artworkUrl100 ?? "", completion: { (data:Data?) in
                    XCTAssertNotNil(feed?.feed?.results?.first?.artworkUrl100, "img data Should not be empty")
                })
                }
            case .fail(let error)?:
                XCTAssertNil(error, "Error should  be nil")
            case .none:
                break
            }
       
        }
    }

    func testImgCache(){
        let viewModel =  AlbumViewModel(feed: nil, imageCache: MockDataManager.imageCache, delegate: nil, dataManager: MockDataManager())
        XCTAssertNotNil(viewModel.imageCache, "imgcache Should not be empty")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    
}

class MockDataManager: AlbumDataManager {
    var responseStatus:ResponseStatus = .sucess
    
    enum ResponseStatus:Int {
        case sucess
        case fail
    }
    
    override  func getFeeds(completion:@escaping ((_ feed:Feeds?, _ responseResult:ResponseResult?) -> Void)) {
        getData(completion: completion)
    }
    
    func getData(completion:@escaping ((_ feed:Feeds?, _ responseResult:ResponseResult?) -> Void)) {
        if self.responseStatus == .fail {
            completion(nil, ResponseResult(code: 404, headerFileds: nil, description: "No Json Data Available", error: nil))
        }
        else {
        guard let path = Bundle.main.path(forResource: "jsondata.json", ofType: nil) else { return }
        do {
            //here dataResponse received from a network request
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let feed = try decoder.decode(Feeds.self, from:
                data)
            completion(feed, nil)
        }catch let error {
            print("error")
            completion(nil, ResponseResult(code: 404, headerFileds: nil, description: error.localizedDescription, error: nil))
        }
        }
    }
    
    override  func getImage(imgUrl:String, completion:@escaping ((_ albumData:Data?, _ responseResult:ResponseResult?) -> Void)) {
        super.getImage(imgUrl: imgUrl, completion: completion)
    }
}
