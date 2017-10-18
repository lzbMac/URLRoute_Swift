//
//  String+URLCode.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/9.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import Foundation

public extension String {
    func isWhitespace() -> Bool {
        let whitespace = CharacterSet.whitespaces
        
        for char in self.unicodeScalars {
            if whitespace.contains(char) {
                return false
            }
        }
        return true
    }
    
    func isEmptyOrWhitespace() -> Bool {
        return (self.characters.count == 0) || (self.trimmingCharacters(in: CharacterSet.whitespaces).characters.count == 0)
    }
    
    func containString(_ string: String) -> Bool {
        if let _ = self.range(of: string, options: .caseInsensitive)
        {
            return true
        }
        return false
    }
    
    func containString(_ string: String, options: CompareOptions) ->Bool {
        if let _ = self.range(of: string, options: options)
        {
            return true
        }
        return false
    }
    
    func URLEncodedString() -> String {
        let string = CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (self as CFString), ("!$&'()*+,-./:;=?@_~%#[]" as CFString))
        
        if let str = string {
            return str as String
        }
        return self;
    }
    
    func URLDecodedString() -> String {
        let string = CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, self as CFString, "" as CFString)
        
        if let str = string {
            return str as String
        }
        return self;
    }
    
    var unicodeStr:String {
        let tempStr1 = self.replacingOccurrences(of: "\\u", with: "\\U")
        let tempStr2 = tempStr1.replacingOccurrences(of: "\"", with: "\\\"")
        let tempStr3 = "\"".appending(tempStr2).appending("\"")
        let tempData = tempStr3.data(using: .utf8)
        var returnStr:String = ""
        do {
            returnStr = try PropertyListSerialization.propertyList(from: tempData!, options: .mutableContainers, format: nil)as! String
        } catch {
            print(error)
        }
        return returnStr.replacingOccurrences(of: "\\r\\n", with: "\n")
    }
}
