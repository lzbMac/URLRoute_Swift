//
//  String+RemoveUnderscoreAndInitials.swift
//  URLRoute_Swift
//
//  Created by 李正兵 on 2017/9/9.
//  Copyright © 2017年 李正兵. All rights reserved.
//

import Foundation

public extension String {
    func removeUnderscoreAndInitials() -> String {
        let rString = self
        
        let range: Range? = self.range(of: "_")
        guard let _ = range else {
            return rString
        }
        var mutStrings = self.components(separatedBy: "_")
        
        for obj in mutStrings {
            if mutStrings.index(of: obj)! > 0 {
                mutStrings[mutStrings.index(of: obj)!] = obj.capitalized
            }
        }
        return mutStrings.joined(separator: "")
    }
}
