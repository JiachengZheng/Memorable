//
//  JCAddEventModel.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/23.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCAddEventModel: JCBaseModel {
    override func loadItem(param: [String: AnyObject]?,complete: ([String: AnyObject]?-> Void),failure: ([String: AnyObject]?-> Void)){
        self.items.removeAll()
        let item1 = JCAddEventNameItem()
        let item2 = JCAddEventDateItem()
        item2.date = dateToStr(NSDate())
        let item3 = JCAddEventTimeItem()
        let item4 = JCAddEventCategoryItem()
        item4.category = "生活"
        let item5 = JCAddEventTopItem()
        item5.on = false
        items = [item1,item2,item3,item4,item5]
        complete(nil)
    }
}
