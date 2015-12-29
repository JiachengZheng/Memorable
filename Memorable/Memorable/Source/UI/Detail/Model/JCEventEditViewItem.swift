//
//  JCEventEditViewItem.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/28.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit
enum EditTableViewItemType: Int{
    case Name,Date,Time,Type,Top
    var description: String {
        switch self{
        case .Name: return "事件名"
        case .Date: return "日期"
        case .Time: return "时间"
        case .Type: return "分类"
        case .Top: return "置顶"
        }
    }
}
class JCEventEditViewItem: NSObject {
    var itemType: EditTableViewItemType
    var text: String
    var isTop: Bool
    
    init(itemType: EditTableViewItemType,text: String = "",isTop:Bool = false) {
        self.itemType = itemType
        self.text = text
        self.isTop = isTop
    }
}
