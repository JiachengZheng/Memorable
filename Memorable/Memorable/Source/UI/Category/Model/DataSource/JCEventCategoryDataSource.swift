//
//  JCEventCategoryDataSource.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/29.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCEventCategoryDataSource: JCBaseTableViewDataSource {
    override func tableView(tableView: UITableView, cellClassForObject object: AnyObject) -> JCBaseTableViewCell.Type {
        if object is JCEventCategoryItem{
            return JCEventCategoryCell.self
        }
        return super.tableView(tableView, cellClassForObject: object)
    }

    
}
