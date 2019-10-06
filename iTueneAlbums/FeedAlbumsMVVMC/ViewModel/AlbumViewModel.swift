//
//  AlbumViewModel.swift
//  iTueneAlbums
//
//  Created by Suresh Dokula on 10/5/19.
//  Copyright © 2019 suresh. All rights reserved.
//

import Foundation

enum  DataFetchStatus {
    case success(Feeds?)
    case fail(ResponseResult?)
}

struct AlbumViewModel {
    
     var feed:Feeds?
     var imageCache = AlbumDataManager.imageCache
     var delegate:AppCoordinatorDelegate?
     var dataManager:AlbumDataManager?
    
     init(feed:Feeds?, imageCache:NSCache<NSString, NSData>, delegate:AppCoordinatorDelegate?, dataManager:AlbumDataManager?) {
        self.feed = feed
        self.imageCache = imageCache
        self.delegate = delegate
        self.dataManager = dataManager
    }

    mutating func jsonParsing( completion:@escaping ((_ result:DataFetchStatus?) -> Void)){
        self.dataManager?.getFeeds { (feed:Feeds?, responseResult:ResponseResult?) in
            guard let _ = feed  else { return completion(DataFetchStatus.fail(responseResult))}
            completion(DataFetchStatus.success(feed))
        }
    }
    
     func getImage(imgUrl:String, completion:@escaping ((_ data:Data?) -> Void)){
      
        self.dataManager?.getImage(imgUrl: imgUrl) { (data:Data?, responseResult:ResponseResult?) in
            guard let data = data  else { return completion(nil)}
            completion(data)
        }
        
    }

}
