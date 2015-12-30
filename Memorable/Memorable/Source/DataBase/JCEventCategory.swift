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
    
    dynamic var id: String?
    dynamic var categoryName: String?
    
    override class func primaryKey()-> String{
        return "id"
    }
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
