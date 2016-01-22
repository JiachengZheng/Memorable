//
//  JCListDataSource.swift
//  Memorable
//
//  Created by 郑嘉成 on 16/1/4.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCListDataSource: JCBaseTableViewDataSource {
    override func tableView(tableView: UITableView, cellClassForObject object: AnyObject) -> JCBaseTableViewCell.Type {
        if object is JCListItem{
            return JCListTableViewCell.self
        }
        return super.tableView(tableView, cellClassForObject: object)
    }
}
