//
//  Feeds.swift
//  jsonParsing
//
//  Created by Suresh Dokula on 10/1/19.
//  Copyright © 2019 mdtmac. All rights reserved.
//

import Foundation
struct Feeds: Codable {
    let feed:Feed?
}

struct Feed: Codable {
       let title:String?
       let id:String?
       let copyright:String?
       let country:String?
       let icon:String?
       let updated:String?
       let author:Author?
       let links:[Links]?
       let results:[Album]?
}
