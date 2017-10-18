//
//  URLRouteScheme.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/11.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import UIKit

private let URLRouteVersion = "URLRouteVersion"

let kRouteSchemeNative     = "ttsclient"
let kRouteSchemeExternal   = "external"
let kRouteSchemeWeb        = "http"
let kRouteSchemeSECWeb     = "https"
let kRouteSchemeFile       = "file"
let kRouteSchemeClient     = "tticar" //外部/浏览器启动客户端

class URLRouteScheme: NSObject {
    private(set) var originalURL: URL
    private(set) var useableURL: URL?
    private(set) var query: String?
    private(set) var scheme: String?
    private(set) var module: String?

    private(set) var page: String?
    private(set) var parameter: [String: String]?
    
    init(_ url: URL) {
        self.originalURL = url
        let aURL = self.originalURL
        
        scheme = aURL.scheme
        if let scheme = self.scheme {
            switch scheme {
            case kRouteSchemeNative, kRouteSchemeWeb, kRouteSchemeFile, kRouteSchemeSECWeb:
                useableURL = aURL
            case kRouteSchemeExternal, kRouteSchemeClient:
                if let newScheme = aURL.host, let newQuery = aURL.query {
                    let newURLString = newScheme + ":/" + aURL.path + "?" + newQuery
                    useableURL = URL(string: newURLString)
                }
            default:
                useableURL = nil
                self.scheme = nil
            }
        }
        module = useableURL?.host?.removeUnderscoreAndInitials()
        
        if let path = useableURL?.path, path.characters.count > 0 {
            page = path.substring(from: path.index(after: path.startIndex))
        }
        query = useableURL?.query
        
        var urlDict = [String: String].dictionary(query: query)
        urlDict[URLRouteVersion] = "1"
        
        for (key, value) in urlDict {
            urlDict[key] = value.removeUnderscoreAndInitials()
        }
        parameter = urlDict
    }
    
    class func isStandard(url: URL) -> Bool {
        if let scheme = url.scheme {
            var isStandard = URLRouteScheme.isStandard(scheme: scheme)
            if !isStandard && scheme == kRouteSchemeClient {
                if let nScheme = url.host {
                    isStandard = URLRouteScheme.isStandard(scheme: nScheme)
                }
            }
            return isStandard
        }
        return false
    }
    
    private class func isStandard(scheme: String) -> Bool {
        return scheme == kRouteSchemeNative ||
            scheme == kRouteSchemeExternal ||
            scheme == kRouteSchemeWeb ||
            scheme == kRouteSchemeFile ||
            scheme == kRouteSchemeSECWeb
    }
}
