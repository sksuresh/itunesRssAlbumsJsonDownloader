//
//  Links.swift
//  jsonParsing
//
//  Created by Suresh Dokula on 10/1/19.
//  Copyright © 2019 mdtmac. All rights reserved.
//

import Foundation
struct Links: Codable {
    let selflink:String?
    let alternate:String?
    enum CodingKeys: String, CodingKey {
        case selflink = "self"
        case alternate
    }
    
}
