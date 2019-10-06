//
//  AppErrors.swift
//  iTueneAlbums
//
//  Created by Suresh Dokula on 10/5/19.
//  Copyright © 2019 suresh. All rights reserved.
//

import Foundation

public enum AppErrors {
    case invalidUrl(String)
    case error(Error?)
    case details(String,String)
    case serviceError(Int,String)
    
    public var error:AppErrors? {
        switch self {
        case .invalidUrl(let url):
            return .details("Invalid Url", url)
        case .error(let error?):
            return .details(error.localizedDescription, "error")
        case .serviceError(let code, let reason):
            return .details(String(code), reason)
        default:
            return .details("Invalid ", "Invalid")
        }
    }
}
