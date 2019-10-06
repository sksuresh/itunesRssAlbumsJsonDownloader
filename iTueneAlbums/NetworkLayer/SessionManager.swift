//
//  SessionManager.swift
//  iTueneAlbums
//
//  Created by Suresh Dokula on 10/5/19.
//  Copyright © 2019 suresh. All rights reserved.
//

import Foundation

struct SessionManager {

    static var shared = SessionManager()
    let queue = DispatchQueue(label: "feeds.album.com")
    static var serivceWatch:[String:ServiceWatch] = [:]
    
    mutating func request(url: String,method: HttpMethod = .get,parameters: [String:Any]? = nil,headers: HTTPHeaders? = nil,  completion:@escaping ((_ data:Data?, _ error :Error?, _ responseResult: ResponseResult? ) -> Void)) {
        
        guard let request = dataRequest(url: url, headers: headers ?? nil, method: method,parameters: parameters) else { return completion(nil, nil, ResponseResult(code: 50, headerFileds: nil, description: "Failed To Create Request", error: nil)) }
        
        queue.wait(seconds: 0.1) {
            
            //adding requet to watch
            let watchRequest = ServiceWatch()
            watchRequest.startDate = Date()
            watchRequest.request = request
            SessionManager.serivceWatch[url] = watchRequest
            
            //starting request to download data
            let session = URLSession.shared
            session.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
                //adding response to watch
                var responseResult:ResponseResult? = nil
                let watchRequest = SessionManager.serivceWatch[url]
                watchRequest?.endDate = Date()
                watchRequest?.response = response
                if let httpUrlResponse:HTTPURLResponse = response as? HTTPURLResponse {
                    watchRequest?.result = ResponseResult(code: httpUrlResponse.statusCode,headerFileds: httpUrlResponse.allHeaderFields.debugDescription, description:httpUrlResponse.debugDescription, error:error)
                    responseResult = watchRequest?.result
                } else {
                    responseResult = ResponseResult(code: nil,headerFileds:nil , description:error?.localizedDescription, error:error)
                }
                //returning result to data access layer
                completion(data,error, responseResult)
            }).resume()
        }
    }
   
    
   private func dataRequest(url:String, headers:HTTPHeaders?, method:HttpMethod,parameters:[String:Any]?) -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        if let headers = headers {
        request.allHTTPHeaderFields = headers.dictionary
        }
        request.httpMethod = method.rawValue
        return request
    }
    
   
}
