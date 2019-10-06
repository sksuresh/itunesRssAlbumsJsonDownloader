//
//  Album.swift
//  jsonParsing
//
//  Created by Suresh Dokula on 10/5/19.
//  Copyright © 2019 mdtmac. All rights reserved.
//

import Foundation
struct Album: Codable {
    let artistName:String?
    let id:String?
    let releaseDate:String?
    let name:String?
    let kind:String?
    let copyright:String?
    let artistId:String?
    let artistUrl:String?
    let artworkUrl100:String?
    let url:String?
    let genres:[Genres]?
}

struct Genres: Codable {
    let genreId:String?
    let name:String?
    let url:String?
}
