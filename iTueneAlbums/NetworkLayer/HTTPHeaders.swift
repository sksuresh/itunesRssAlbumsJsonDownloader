//
//  HTTPHeaders.swift
//  iTueneAlbums
//
//  Created by Suresh Dokula on 10/5/19.
//  Copyright © 2019 suresh. All rights reserved.
//

import Foundation
struct HTTPHeaders: Hashable {
    var headers:[HTTPHeaders] = []
    let name:String
    let value:String
    
    init(name:String, value:String) {
        self.name = name
        self.value = value
    }
    
    public mutating func update(_ header: HTTPHeaders) {
        guard let index = headers.lastIndex(of: header) else {
            headers.append(header)
            return
        }
        
        headers.replaceSubrange(index...index, with: [header])
    }
    public var dictionary: [String: String] {
        let namesAndValues = headers.map { ($0.name, $0.value) }
        
        return Dictionary(namesAndValues, uniquingKeysWith: { _, last in last })
    }
}

extension HTTPHeaders {
    public static func contentType(_ value: String) -> HTTPHeaders {
        return HTTPHeaders(name: "Content-Type", value: value)
    }

}
