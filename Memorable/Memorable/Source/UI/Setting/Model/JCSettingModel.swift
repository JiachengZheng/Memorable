//
//  JCSettingModel.swift
//  Memorable
//
//  Created by zhengjiacheng on 16/1/22.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCSettingModel: JCBaseModel {
    override func loadItem(param: [String: AnyObject]?,complete: ([String: AnyObject]?-> Void),failure: ([String: AnyObject]?-> Void)){
        self.items.removeAll()
        let item1 = JCSettingSectionItem()
        item1.text = "提醒"
        let item2 = JCSettingSwitchItem()
        item2.text = "开启通知"
        let setting = UIApplication.sharedApplication().currentUserNotificationSettings()
        item2.on = true
        if setting?.types.rawValue == 0{
            item2.on = false
        }
        let item3 = JCSettingSwitchItem()
        item3.text = "图标数字"
        item3.on = true
        if setting?.types.rawValue == 0{
            item3.on = false
        }
        let item4 = JCSettingSwitchItem()
        item4.text = "置顶事件每日提醒"
        item4.on = true
        if setting?.types.rawValue == 0{
            item4.on = false
        }
        let item5 = JCSettingSectionItem()
        item5.text = "排序"
        let item6 = JCSettingSelectItem()
        item6.title = "排序方式"
        item6.detail = "按时间排序"
        let item7 = JCSettingSectionItem()
        item7.text = "通知中心插件"
        let item8 = JCSettingSelectItem()
        item8.title = "显示事件数量"
        item8.detail = "3"
        let item9 = JCSettingSwitchItem()
        item9.text = "日历"
        item9.on = false
        let item10 = JCSettingSelectItem()
        item10.title = "显示分类"
        item10.detail = "生活"
        let item11 = JCSettingSectionItem()
        item11.text = "iCloud"
        let item12 = JCSettingSelectItem()
        item12.title = "备份到iCloud"
        let item13 = JCSettingSelectItem()
        item13.title = "从iCloud恢复"
        let item14 = JCSettingSectionItem()
        item14.text = "支持"
        let item15 = JCSettingSelectItem()
        item15.title = "评论"
        let item16 = JCSettingSelectItem()
        item16.title = "版本"
        item16.detail = "1.0.0"
        items = [item1,item2,item3,item4,item5,item6,item7,item8,item9,item10,item11,item12,item13,item14,item15,item16]
        complete(nil)
    }
    
}
