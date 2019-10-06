//
//  AlbumDataManager.swift
//  iTueneAlbums
//
//  Created by Suresh Dokula on 10/5/19.
//  Copyright © 2019 suresh. All rights reserved.
//

import Foundation

class AlbumDataManager {
    
    static var imageCache = NSCache<NSString, NSData>()

     func getFeeds(completion:@escaping ((_ feed:Feeds?, _ responseResult:ResponseResult?) -> Void)) {
        SessionManager.shared.request(url:URLDataPoint.stringUrl(path: .rssFeedAlbum)) { (data:Data?, error:Error?, responseResult:ResponseResult?) in
                guard let data = data  else { return  completion(nil, responseResult) }
                do {
                    let decoder = JSONDecoder()
                    let feed = try decoder.decode(Feeds.self, from: data)
                    completion(feed, nil)
                } catch  _ {
                        completion(nil, responseResult)
                }
            }
    }
    
     func getImage(imgUrl:String, completion:@escaping ((_ albumData:Data?, _ responseResult:ResponseResult?) -> Void)) {
        if let data = AlbumDataManager.imageCache.object(forKey: imgUrl as NSString) {
            completion(data as Data, nil)
        }else {
            SessionManager.shared.request(url:imgUrl) { (data:Data?, error:Error?, responseResult:ResponseResult?) in
            guard let data = data, let nsdata =  data as? NSData  else { return  completion(nil, responseResult) }
            AlbumDataManager.imageCache.setObject(nsdata, forKey: imgUrl as NSString)
            completion(data, nil)
            }
        }
    }
}
