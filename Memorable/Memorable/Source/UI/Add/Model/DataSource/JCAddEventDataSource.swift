//
//  JCAddEventDataSource.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/23.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCAddEventDataSource: JCBaseTableViewDataSource {
    override func tableView(tableView: UITableView, cellClassForObject object: AnyObject) -> JCBaseTableViewCell.Type {
        if object is JCAddEventNameItem{
            return JCAddEventNameCell.self
        }else if object is JCAddEventDateItem{
            return JCAddEventDateCell.self
        }else if object is JCAddEventTimeItem{
            return JCAddEventTimeCell.self
        }else if object is JCAddEventCategoryItem{
            return JCAddEventCategoryCell.self
        }else if object is JCAddEventTopItem{
            return JCAddEventTopCell.self
        }
        return super.tableView(tableView, cellClassForObject: object)
    }
}
