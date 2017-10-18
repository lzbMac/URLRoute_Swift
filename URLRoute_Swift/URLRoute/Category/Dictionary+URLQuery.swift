//
//  Dictionary+URLQuery.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/9.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import Foundation

public extension Dictionary where Key == String, Value == String{
    static func dictionary(query: String?) -> [String: String]{
        var parameters = [String: String]()
        guard let pramas = query, let _ = pramas.range(of: "=") else {
            return parameters
        }
        let keyValuePairs = query!.components(separatedBy: "&")
        for keyValuePair in keyValuePairs {
            let pair: [String]? = keyValuePair.components(separatedBy: "=")
            let paramValue = pair?.count == 2 ? pair?.last : ""
            var input: String? = paramValue?.replacingOccurrences(of: "+", with: " ", options: .literal, range: paramValue!.range(of: paramValue!))
            input = input?.removingPercentEncoding
            
            if let key = pair?.first, let value = input {
                parameters.updateValue(value, forKey: key)
            }
        }
        return parameters
    }
}
