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
    dynamic var bgName = ""
    
    override class func primaryKey()-> String{
        return "id"
    }
}
