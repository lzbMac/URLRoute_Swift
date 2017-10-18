//
//  URL+RouteHook.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/9.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import Foundation

public extension URL {
    static func routeURL(URLString: String) -> URL? {
        var url = URL(string: URLString)
        if url == nil {
            let markArray = URLString.components(separatedBy: "?")
            
            if markArray.count == 2 {
                let query = markArray.last
                let dict = Dictionary.dictionary(query: query)
                var aParameter = ""
                
                for (key, value) in dict {
                    aParameter.append(key + "=" + value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! + "&")
                }
                let newURLString = markArray.first! + "?" + aParameter.dropLast()
                url = URL(string: newURLString)
            }
        }
        return url
    }
}
