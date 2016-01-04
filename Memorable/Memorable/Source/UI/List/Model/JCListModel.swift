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
        self.items.append(JCListItem())
        self.items.append(JCListItem())
        self.items.append(JCListItem())
        self.items.append(JCListItem())
        self.items.append(JCListItem())
        complete(nil)
    }
}
