//
//  JCSettingDataSource.swift
//  Memorable
//
//  Created by zhengjiacheng on 16/1/22.
//  Copyright © 2016年 zhengjiacheng. All rights reserved.
//

import UIKit

class JCSettingDataSource: JCBaseTableViewDataSource {
    override func tableView(tableView: UITableView, cellClassForObject object: AnyObject) -> JCBaseTableViewCell.Type {
        if object is JCSettingSelectItem{
            return JCSettingSelectCell.self
        }else if object is JCSettingSectionItem{
            return JCSettingSectionCell.self
        }else if object is JCSettingSwitchItem{
            return JCSettingSwitchCell.self
        }
        return super.tableView(tableView, cellClassForObject: object)
    }
}
