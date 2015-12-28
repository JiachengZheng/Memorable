//
//  JCDetailEditViewDataSource.swift
//  Memorable
//
//  Created by zhengjiacheng on 15/12/28.
//  Copyright © 2015年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCDetailEditViewDataSource: JCBaseTableViewDataSource {
    override func tableView(tableView: UITableView, cellClassForObject object: AnyObject) -> JCBaseTableViewCell.Type {
        if object is JCDetailEditViewItem{
            return JCDetailEditTableViewCell.self
        }
        return super.tableView(tableView, cellClassForObject: object)
    }
}
