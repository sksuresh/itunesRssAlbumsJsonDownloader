//
//  URLConvertor.swift
//  iTueneAlbums
//
//  Created by Suresh Dokula on 10/5/19.
//  Copyright © 2019 suresh. All rights reserved.
//

import Foundation
enum methodType: String {
    case json = "json"
    case query = "query"
}

struct URLConvertor {
    
    var method:methodType? = nil
    var url:String? = nil
    
    init(method:methodType,url:String) {
        self.method = method
        self.url = url
    }

}

struct URLDataPoint {
    static func stringUrl(host:HostType = HostType.https, domain: HostDomains = HostDomains.rssFeed, path:URLPaths) -> String {
        return host.rawValue + domain.rawValue + path.rawValue
    }
}


public extension DispatchQueue {
    func wait(seconds: Double, completion: @escaping () -> Void) {
        asyncAfter(deadline: .now() + seconds) { completion() }
    }
}

public enum HostDomains:String {
    case rssFeed = "rss.itunes.apple.com"
}


public enum URLPaths:String {
    case rssFeedAlbum = "/api/v1/us/apple-music/coming-soon/all/100/explicit.json"
}

public enum HostType:String {
    case https = "https://"
    case http = "http://"
    case ftp = "ftp://"
}
