//
//  JCEventCategoryModel.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/29.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCEventCategoryModel: JCBaseModel {
    override func loadItem(param: [String : AnyObject]?, complete: ([String : AnyObject]? -> Void), failure: ([String : AnyObject]? -> Void)) {
        let list = eventRealm.objects(JCEventCategory)
        if list.count == 0{
            failure(nil)
            return
        }
        for item in list{
            self.items.append(JCEventCategoryItem(text: item.categoryName!))
        }
        complete(nil)
    }
}
