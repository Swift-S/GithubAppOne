//
//  GithubRouter.swift
//  Github App
//
//  Created by Amir Daliri on 10/22/16.
//  Copyright © 2016 Amir Daliri. All rights reserved.
//

import Foundation
import Alamofire

public enum GithubRouter: URLRequestConvertible {
    
    static let baseURLPath = "https://api.github.com"
    //TODO: Replace xxx with your auth token found at https://imagga.com/profile/dashboard
    static let authenticationToken = "Basic xxx"
    
    case Content
    case Tags(String)
    case Colors(String)
    
    public var URLRequest: NSMutableURLRequest {
        let result: (path: String, method: Alamofire.Method, parameters: [String: AnyObject]) = {
            switch self {
            case .Content:
                return ("/content", .POST, [String: AnyObject]())
            case .Tags(let contentID):
                let params = [ "content" : contentID ]
                return ("/tagging", .GET, params)
            case .Colors(let contentID):
                let params = [ "content" : contentID, "extract_object_colors" : NSNumber(int: 0) ]
                return ("/colors", .GET, params)
            }
        }()
        
        let URL = NSURL(string: GithubRouter.baseURLPath)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
        URLRequest.HTTPMethod = result.method.rawValue
        URLRequest.setValue(GithubRouter.authenticationToken, forHTTPHeaderField: "Authorization")
        URLRequest.timeoutInterval = NSTimeInterval(10 * 1000)
        
        let encoding = Alamofire.ParameterEncoding.URL
        
        return encoding.encode(URLRequest, parameters: result.parameters).0
    }
    
}
