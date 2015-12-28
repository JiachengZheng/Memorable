//
//  JCEvent.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/27.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import Foundation
import RealmSwift

 class JCEvent: Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var date = ""
    dynamic var time =  ""
    dynamic var type = ""
    dynamic var isTop = false
    
    override class func primaryKey()-> String{
        return "id"
    }
    // Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
