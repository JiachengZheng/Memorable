//
//  JCListItem.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/4.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCListItem: NSObject {
    var name: String
    var id: String?
    var date: String?
    init(id: String,name: String, date: String) {
        self.name = name
        self.id = id
        self.date = date
    }
}
