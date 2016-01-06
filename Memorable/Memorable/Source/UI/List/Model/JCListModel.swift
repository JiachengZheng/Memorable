//
//  JCListModel.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/4.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCListModel: JCBaseModel {
    override func loadItem(param: [String : AnyObject]?, complete: ([String : AnyObject]? -> Void), failure: ([String : AnyObject]? -> Void)) {
        self.items.removeAll()
        let list = eventRealm.objects(JCEvent)
        for obj in list {
            self.items.append(JCListItem(id: obj.id, name: obj.name, date: obj.date))
        }
        complete(nil)
    }
}
