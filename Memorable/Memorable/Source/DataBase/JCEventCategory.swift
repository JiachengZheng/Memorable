//
//  JCEventCategory.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/29.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import Foundation
import RealmSwift

class JCEventCategory: Object {
    
    var id: String?
    var categoryName: String?
    
    override class func primaryKey()-> String{
        return "categoryName"
    }
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
