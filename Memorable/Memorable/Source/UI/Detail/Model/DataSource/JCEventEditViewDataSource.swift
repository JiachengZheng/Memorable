//
//  JCEventEditViewDataSource.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/28.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCEventEditViewDataSource: JCBaseTableViewDataSource {
    override func tableView(tableView: UITableView, cellClassForObject object: AnyObject) -> JCBaseTableViewCell.Type {
        if object is JCEventEditViewItem{
            return JCEventEditTableViewCell.self
        }
        return super.tableView(tableView, cellClassForObject: object)
    }
}
