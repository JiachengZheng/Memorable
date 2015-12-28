//
//  JCStringExtension.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/27.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import Foundation

extension String{
    var trimString:String{
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }

    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = self.startIndex.advancedBy(r.endIndex)
            
            return self[Range(start: startIndex, end: endIndex)]
        }
    }
    
}